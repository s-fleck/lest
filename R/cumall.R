#' Cumulative all and any
#'
#' @param x a `logical` vector.
#' @return a `logical` vector
#' @export
#'
#' @examples
#' cumall(c(TRUE, TRUE, NA, TRUE, FALSE))
#' cumany(c(FALSE, FALSE, NA, TRUE, FALSE))
cumall <- function(x) {
  .Call("cumall_", x)
}




#' @rdname cumall
#' @export
cumany <- function(x) {
  .Call("cumany_", x)
}
