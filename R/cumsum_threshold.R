#' Cummulative thresholds for sum
#'
#' Check
#'
#' @param x a `numeric` vector
#' @param threshold a `numeric` scalar
#'
#' @rdname cumall
#' @export
#' @example
#'
#' cumsum_threshold(c(1, 3, 3, 3), 4)
#'
cumsum_threshold <- function(x, threshold) {
  assert(is.numeric(x))
  assert(is_scalar_numeric(threshold))

  x <- as.double(x)
  threshold <- as.double(threshold)

  .Call("C_cumsum_threshold", x, threshold)
}
