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

  assert_length_1_or_n(val, length(x), name, reason)
  assert_equal_type(val, x, name)
  assert_equal_class(val, x, name)

  i[is.na(i)] <- FALSE
  if (length(val) == 1L) {
    x[i] <- val
  } else {
    x[i] <- val[i]
  }
  x
}




assert_equal_type <- function(
  x,
  template,
  header
){
  if (identical(typeof(x), typeof(template)))
    return(TRUE)

  if (is.null(header))
    header <- ""
  else
    header <- paste0(header, " ")

  stop(sprintf("%smust be type %s, not %s", header, typeof(template), typeof(x)))
}




assert_equal_class <- function(
  x,
  template,
  header
){
  if (!is.object(x)) {
    return(TRUE)

  } else if (identical(class(x), class(template))) {
    return(TRUE)

  } else {

    if (is.null(header))
      header <- ""
    else
      header <- paste0(header, " ")


    stop(
      sprintf(
        "%smust be %s, not %s",
        header,
        paste(class(template), collapse = "/"),
        paste(class(x), collapse = "/")
      )
    )
  }
}




check_length_1_or_n <- function(
  x,
  n,
  header,
  reason
){
  if (length(x) %in% c(1, n)){
    return(NULL)
  }


  if (is.null(reason))
    reason <- ""
  else
    reason <- paste0(" (", reason, ")")

  if (is.null(header))
    header <- ""
  else
    header <- paste0(header, " ")


  inconsistent_lengths_message(length(x), n, header = header, reason = reason)
}




assert_length_1_or_n <- function(
  x,
  n,
  header,
  reason
){
  chk <- check_length_1_or_n(x, n, header, reason)

  if (is.null(chk)){
    TRUE
  } else {
    stop(chk)
  }
}




# messages ----------------------------------------------------------------

inconsistent_lengths_message <- function(
  length_is,
  length_should,
  header = "",
  reason = ""
){
  if (length_should == 1) {
    sprintf("%smust be length 1%s, not %s", header, reason, paste(length_is, collapse = ", "))
  } else {
    sprintf("%smust be length %s%s or one, not %s", header, length_should, reason, paste(length_is, collapse = ", "))
  }
}
