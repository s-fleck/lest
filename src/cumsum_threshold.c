#include <R.h>
#include <Rinternals.h>

SEXP C_cumsum_threshold(SEXP x, SEXP threshold) {
  R_xlen_t n = XLENGTH(x);
  SEXP res = PROTECT(allocVector(LGLSXP, n));

  double *p_x   = REAL(x);
  double *p_threshold = REAL(threshold);
  double cumsum = 0;
  int *p_res = LOGICAL(res);

  for (R_xlen_t i = 0; i < n; i++) {
    cumsum += p_x[i];

    if (cumsum >= *p_threshold) {
      p_res[i] = TRUE;
      cumsum = 0;
    } else {
      p_res[i] = FALSE;
    }
  }

  UNPROTECT(1);
  return res;
}
