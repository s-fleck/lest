// In C ----------------------------------------
#include <R.h>
#include <Rinternals.h>

SEXP cumall_impl(SEXP x) {
  SEXP res = PROTECT(allocVector(LGLSXP, XLENGTH(x)));
  R_xlen_t n = XLENGTH(x);

  if (n == 0){
    UNPROTECT(1);
    return(res);
  } else {
    memset(LOGICAL(res), 0, n * sizeof(int));
  }

  int *p_x = LOGICAL(x);
  int *p_res = LOGICAL(res);
  p_res[0] = p_x[0];

  for (R_xlen_t i = 1; i < n; i++) {
    if (p_x[i] == TRUE)
      p_res[i] = p_res[i - 1];
    else if (p_x[i] == NA_LOGICAL)
      p_res[i] = NA_LOGICAL;
    else
      break;
  }

  UNPROTECT(1);
  return res;
}
