test_that("case_when can be used in anonymous functions (#3422)", {
  res <- tibble::tibble(a = 1:3) %>%
    dplyr::mutate(b = (function(x) case_when(x < 2 ~ TRUE, TRUE ~ FALSE))(a)) %>%
    dplyr::pull()
  expect_equal(res, c(TRUE, FALSE, FALSE))
})
