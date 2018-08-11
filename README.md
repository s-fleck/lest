# lest

[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

Lest provides two functions for vectorised conditional recoding of variables.
`case_when()` enables you to vectorise multiple `if` and `else` statements (like
`CASE WHEN` in SQL). `if_else()` is a stricter and more predictable version of
`base::ifelse()` that preverves attributes (and therefore works with Dates). The
functions in lest are forks of the
[dplyr](https://CRAN.R-project.org/package=dplyr) functions of
the same name.

**lest** depends only on base, and will never add any external dependencies.



Why use lest?
----------------------------------

Use this package if you like the semantics of `dplyr::case_when()`, but do not 
want to use dplyr because of the dependencies it comes with. 
**If you already use dplyr in your project, you gain no advantage from lest**. 
`lest::case_when()` and `lest::if_else()` behave exactly identical to 
the dplyr equivalents, just that they do not support tidyeval syntax 
(like `!!!`).



Installation
------------

You can install lest from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("s-fleck/lest")
```


Example
-------

``` r
x <- 1:50

case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  TRUE ~ as.character(x)
)

case_when(
  x %% 35 == 0 ~ 35,
  x %% 5 == 0 ~ 5,
  x %% 7 == 0 ~ 7,
  TRUE ~ NA
)

```
