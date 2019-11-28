#' Check When the Tumbling Sum of a Vector Exceeds a Threshold
#'
#' The tumbling sum is calculated as the partial cumulative sum of a vector
#' until a threshold is exceeded. Once this happens, the tumbling sum is
#' calculated from zero again. `exceeds_tumbling_sum()` returns `TRUE` whenever
#' this threshold is hit/exceeded and `FALSE` otherwise.
#'
#' This is for example useful if you have high frequency GPS positions
#' and want to keep only points that are at least `x` seconds apart.
#'
#' @param x a `numeric` vector
#' @param threshold a `numeric` scalar
#' @param inclusive a `logical` scalar. If `TRUE` inclusive bounds are used
#'   (i.e. the threshold is checked with `>=`), otherwise exclusive
#'
#' @return a `logical` vector of the same length as `x` that is `TRUE` whenever
#'   `threshold` was exceeded and `FALSE` otherwise
#'
#' @seealso [MESS::cumsumbinning()] does something very similar, but returns
#'   group indices instead of a logical vector.
#'
#' @export
#' @examples
#' exceeds_tumbling_sum(c(1, 3, 3, 3), 4)
exceeds_tumbling_sum <- function(
  x,
  threshold,
  inclusive = TRUE
){
  assert(is_scalar(threshold))
  assert(is_scalar_bool(inclusive))

  if (is.integer(x) && is.integer(threshold)){
    assert(!anyNA(x))
    assert(!is.na(threshold))

    .Call("exceeds_tumbling_sum_int_", x, threshold, inclusive)

  } else {
    x <- as.double(x)
    threshold <- as.double(threshold)
    assert(!anyNA(x))
    assert(!is.na(threshold))

    .Call("exceeds_tumbling_sum_double_", x, threshold, inclusive)
  }
}
