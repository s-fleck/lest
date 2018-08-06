# lest

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

Vectorised Conditionals Similar to SQL CASE WHEN, forked from dplyr but without
any dependencies. 


Relationship to dplyr::case_when() 
----------------------------------

Use this package if you like the semantics of `dplyr::case_when()`, but do not 
want to use dplyr. If you already use dplyr, it is not recommended to use 
**lest**. `lest::case_when()` and `lest::if_else()` behave exactly identical to 
the dplyr equivalents, just that they do not support tidyeval syntax 
(like `!!!`).

The dplyr `suggests` in the package descriptions is just for unit tests. 


Installation
------------

You can install dint from GitHub with:

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
