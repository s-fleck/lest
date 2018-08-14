# case_when ---------------------------------------------------------------

#' A general vectorised if
#'
#' This function allows you to vectorise multiple `if` and `else if`
#' statements. It is an R equivalent of the SQL `CASE WHEN` statement.
#'
#' @param ... A sequence of two-sided formulas. The left hand side (LHS)
#'   determines which values match this case. The right hand side (RHS)
#'   provides the replacement value.
#'
#'   The LHS must evaluate to a logical vector. The RHS does not need to be
#'   logical, but all RHSs must evaluate to the same type of vector.
#'
#'   Both LHS and RHS may have the same length of either 1 or `n`. The
#'   value of `n` must be consistent across all cases. The case of
#'   `n == 0` is treated as a variant of `n != 1`.
#'
#' @return A vector of length 1 or `n`, matching the length of the logical
#'   input or output vectors, with the type (and attributes) of the first
#'   RHS. Inconsistent lengths or types will generate an error.
#'
#' @export
#' @examples
#' x <- 1:50
#' case_when(
#'   x %% 35 == 0 ~ "fizz buzz",
#'   x %% 5 == 0 ~ "fizz",
#'   x %% 7 == 0 ~ "buzz",
#'   TRUE ~ as.character(x)
#' )
#'
#' # Like an if statement, the arguments are evaluated in order, so you must
#' # proceed from the most specific to the most general. This won't work:
#' case_when(
#'   TRUE ~ as.character(x),
#'   x %%  5 == 0 ~ "fizz",
#'   x %%  7 == 0 ~ "buzz",
#'   x %% 35 == 0 ~ "fizz buzz"
#' )
#'
#' # All RHS values need to be of the same type. Inconsistent types will throw an error.
#' # This applies also to NA values used in RHS: NA is logical, use
#' # typed values like NA_real_, NA_complex, NA_character_, NA_integer_ as appropriate.
#' case_when(
#'   x %% 35 == 0 ~ NA_character_,
#'   x %% 5 == 0 ~ "fizz",
#'   x %% 7 == 0 ~ "buzz",
#'   TRUE ~ as.character(x)
#' )
#' case_when(
#'   x %% 35 == 0 ~ 35,
#'   x %% 5 == 0 ~ 5,
#'   x %% 7 == 0 ~ 7,
#'   TRUE ~ NA_real_
#' )
#' # This throws an error as NA is logical not numeric
#' try({
#' case_when(
#'   x %% 35 == 0 ~ 35,
#'   x %% 5 == 0 ~ 5,
#'   x %% 7 == 0 ~ 7,
#'   TRUE ~ NA
#' )
#' })
#' dat <- iris[1:5, ]
#' dat$size <- case_when(
#'   dat$Sepal.Length < 5.0 ~ "small",
#'   TRUE ~ "big"
#' )
#' dat
case_when <- function(...) {
  formulas <- list(...)
  n <- length(formulas)

  if (n == 0) {
    stop("No cases provided")
  }

  query <- vector("list", n)
  value <- vector("list", n)

  for (i in seq_len(n)) {
    f <- formulas[[i]]
    if (!inherits(f, "formula") || length(f) != 3) {
      stop(sprintf(
        "Case %s (`%s`) must be a two-sided formula, not a %s",
        i,
        deparse_trunc(substitute(list(...))[[i + 1]]),
        typeof(f)
      ))
    }

    env <- environment(f)
    query[[i]] <- eval(f[[2]], env)

    if (!is.logical(query[[i]])) {
      stop(sprintf(
        "LHS of case %s (%s) must be a logical, not %s",
        i,
        backticks(deparse_trunc(f_lhs(f))),
        typeof(query[[i]])
      ))
    }

    value[[i]] <- eval(f[[3]], env)
  }

  lhs_lengths <- vapply(query, length, integer(1))
  rhs_lengths <- vapply(value, length, integer(1))
  all_lengths <- unique(c(lhs_lengths, rhs_lengths))

  if (length(all_lengths) <= 1) {
    m <- all_lengths[[1]]
  } else {
    non_atomic_lengths <- all_lengths[all_lengths != 1]
    m <- non_atomic_lengths[[1]]
    if (length(non_atomic_lengths) > 1) {
      inconsistent_lengths <- non_atomic_lengths[-1]
      lhs_problems <- lhs_lengths %in% inconsistent_lengths
      rhs_problems <- rhs_lengths %in% inconsistent_lengths

      bad_calls(
        formulas[lhs_problems | rhs_problems],
        inconsistent_lengths_message(inconsistent_lengths, m)
      )
    }
  }

  out <- value[[1]][rep(NA_integer_, m)]
  replaced <- rep(FALSE, m)

  for (i in seq_len(n)) {
    out <- replace_with(out, query[[i]] & !replaced, value[[i]], NULL)
    replaced <- replaced | (query[[i]] & !is.na(query[[i]]))
  }

  out
}
