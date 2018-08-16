#include <R.h>
#include <Rinternals.h>

SEXP cumall_(SEXP x) {
  R_xlen_t n = XLENGTH(x);
  SEXP res = PROTECT(allocVector(LGLSXP, n));

  int *p_x = LOGICAL(x);
  int *p_res = LOGICAL(res);
  int prev = TRUE;

  for (R_xlen_t i = 0; i < n; i++) {
    if (p_x[i] == TRUE) {
      p_res[i] = prev;
    } else if (p_x[i] == FALSE || prev == FALSE){
      p_res[i] = FALSE;
      prev     = FALSE;
    } else {
      p_res[i] = NA_LOGICAL;
      prev = NA_LOGICAL;
    }
  }

  UNPROTECT(1);
  return res;
}




SEXP cumany_(SEXP x) {
  R_xlen_t n = XLENGTH(x);
  SEXP res = PROTECT(allocVector(LGLSXP, n));

  int *p_x = LOGICAL(x);
  int *p_res = LOGICAL(res);
  int prev = FALSE;

  for (R_xlen_t i = 0; i < n; i++) {
    if (p_x[i] == FALSE) {
      p_res[i] = prev;
    } else if (p_x[i] == TRUE || prev == TRUE){
      p_res[i] = TRUE;
      prev     = TRUE;
    } else {
      p_res[i] = NA_LOGICAL;
      prev = NA_LOGICAL;
    }
  }

  UNPROTECT(1);
  return res;
}
