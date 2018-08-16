#' @keywords internal
#' @useDynLib lest, .registration = TRUE
"_PACKAGE"




.onUnload <- function (libpath) {
  library.dynam.unload("lest", libpath)
}
