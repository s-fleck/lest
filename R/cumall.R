#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
cumall <- function(x) {
  .Call("cumall_impl", x)
}
