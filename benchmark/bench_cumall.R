library(bench)
library(ggplot2)
library(ggbeeswarm)

x <- rep(TRUE, 1e8)
y <- c(rep(TRUE, 1e3), FALSE, rep(TRUE, 1e4))
z <- c(rep(TRUE, 1e3), NA, rep(TRUE, 1e4))

resx <- mark(
  dplyr::cumall(x),
  lest::cumall(x),
  min_iterations = 100
)
autoplot(resx)


resy <- microbenchmark(
  dplyr::cumall(y),
  lest::cumall(y)
)
autoplot(resy)


resz <- microbenchmark(
  dplyr::cumall(z),
  lest::cumall(z)
)
autoplot(resz)
