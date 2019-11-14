#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .Call calls */
extern SEXP cumall_(SEXP);
extern SEXP cumany_(SEXP);
extern SEXP exceeds_tumbling_sum_double_(SEXP, SEXP, SEXP);
extern SEXP exceeds_tumbling_sum_int_(SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"cumall_",                      (DL_FUNC) &cumall_,                      1},
    {"cumany_",                      (DL_FUNC) &cumany_,                      1},
    {"exceeds_tumbling_sum_double_", (DL_FUNC) &exceeds_tumbling_sum_double_, 3},
    {"exceeds_tumbling_sum_int_",    (DL_FUNC) &exceeds_tumbling_sum_int_,    3},
    {NULL, NULL, 0}
};

void R_init_lest(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
