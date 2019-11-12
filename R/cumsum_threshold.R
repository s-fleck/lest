#' Check if cummulative sum of a vector exceedes a certain threshold
#'
#' @param x a `numeric` vector
#' @param threshold a `numeric` scalar
#' @param first,last `logical` scalar. If `TRUE` the first (or last) value(s)
#'   will always be `TRUE`
#'
#' @export
#' @examples
#' cumsum_threshold(c(1, 3, 3, 3), 4)
#'
cumsum_threshold <- function(x, threshold, first = NULL, last = NULL) {
  assert(is.numeric(x))
  assert(is_scalar_numeric(threshold))

  x <- as.double(x)
  threshold <- as.double(threshold)

  res <- .Call("C_cumsum_threshold", x, threshold)

  if (isTRUE(first)){
    res[[1]] <- TRUE
  }

  if (isTRUE(last)){
    res[[length(x)]] <- TRUE
  }

  res
}
