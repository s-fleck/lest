

backticks <- function (x){
  paste0("`", x, "`")
}




deparse_trunc <- function(x, width = getOption("width")){
  text <- deparse(x, width.cutoff = width)
  if (length(text) == 1 && nchar(text) < width)
    return(text)
  paste0(substr(text[1], 1, width - 3), "...")
}




f_lhs <- function(x) x[[2]]




f_rhs <- function(x) x[[3]]




bad_calls <- function(calls, ...){
  stop(fmt_calls(calls), " ", ...)
}




fmt_calls <- function(...){
  paste(backticks(vapply(..., deparse, "")), collapse = ", ")
}




check_length_val <- function(
  length_x,
  n,
  header,
  reason = NULL,
  .stop = stop
){
  if (all(length_x %in% c(1L, n)))
    return()

  if (is.null(reason))
    reason <- ""
  else
    reason <- paste0(" (", reason, ")")

  if (is.null(header))
    header <- ""
  else
    header <- paste0(header, " ")


  if (n == 1) {
    .stop(sprintf("%smust be length 1%s, not %s", header, reason, paste(length_x, collapse = ", ")))
  } else {
    .stop(sprintf("%smust be length %s%s or one, not %s", header, n, reason, paste(length_x, collapse = ", ")))
  }
}




replace_with <- function (
  x,
  i,
  val,
  name,
  reason = NULL
){
  if (is.null(val)) {
    return(x)
  }

  check_length(val, x, name, reason)
  check_type(val, x, name)
  check_class(val, x, name)

  i[is.na(i)] <- FALSE
  if (length(val) == 1L) {
    x[i] <- val
  } else {
    x[i] <- val[i]
  }
  x
}




check_length <- function (
  x,
  template,
  header,
  reason = NULL
){
  check_length_val(length(x), length(template), header, reason)
}




check_type <- function(
  x,
  template,
  header
){
  if (identical(typeof(x), typeof(template))) {
    return()
  }

  if (is.null(header))
    header <- ""
  else
    header <- paste0(header, " ")

  stop(sprintf("%smust be type %s, not %s", header, typeof(template), typeof(x)))
}




check_class <- function(
  x,
  template,
  header
){
  if (!is.object(x)) {
    return()

  } else if (identical(class(x), class(template))) {
    return()

  } else {

    if (is.null(header))
      header <- ""
    else
      header <- paste0(header, " ")


    stop(sprintf("%smust be type %s, not %s", header, typeof(template), typeof(x)))
  }
}




fmt_classes <- function(
  x
){
  paste(class(x), collapse = "/")
}
