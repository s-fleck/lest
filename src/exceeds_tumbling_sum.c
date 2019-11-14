#include <R.h>
#include <Rinternals.h>

SEXP exceeds_tumbling_sum_double_(
    SEXP x,
    SEXP threshold,
    SEXP inclusive
){
  R_xlen_t n = XLENGTH(x);
  SEXP res = PROTECT(allocVector(LGLSXP, n));

  const double *p_x   = REAL(x);
  const double *p_threshold = REAL(threshold);
  const int    *p_inclusive = LOGICAL(inclusive);

  double cumsum = 0;
  int *p_res = LOGICAL(res);

  if (*p_inclusive > 0){
    for (R_xlen_t i = 0; i < n; i++) {
      cumsum += p_x[i];

      if (cumsum >= *p_threshold) {
        p_res[i] = TRUE;
        cumsum = 0;
      } else {
        p_res[i] = FALSE;
      }
    }
  } else {
    for (R_xlen_t i = 0; i < n; i++) {
      cumsum += p_x[i];

      if (cumsum > *p_threshold) {
        p_res[i] = TRUE;
        cumsum = 0;
      } else {
        p_res[i] = FALSE;
      }
    }
  }


  UNPROTECT(1);
  return res;
}




SEXP exceeds_tumbling_sum_int_(
    SEXP x,
    SEXP threshold,
    SEXP inclusive
){
  R_xlen_t n = XLENGTH(x);
  SEXP res = PROTECT(allocVector(LGLSXP, n));

  const int *p_x   = INTEGER(x);
  const int *p_threshold = INTEGER(threshold);
  const int *p_inclusive = LOGICAL(inclusive);

  double cumsum = 0;
  int *p_res = LOGICAL(res);

  if (*p_inclusive > 0){
    for (R_xlen_t i = 0; i < n; i++) {
      cumsum += p_x[i];

      if (cumsum >= *p_threshold) {
        p_res[i] = TRUE;
        cumsum = 0;
      } else {
        p_res[i] = FALSE;
      }
    }
  } else {
    for (R_xlen_t i = 0; i < n; i++) {
      cumsum += p_x[i];

      if (cumsum > *p_threshold) {
        p_res[i] = TRUE;
        cumsum = 0;
      } else {
        p_res[i] = FALSE;
      }
    }
  }


  UNPROTECT(1);
  return res;
}
