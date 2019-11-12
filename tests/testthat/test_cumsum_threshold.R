test_that("cumsum_threshold works as expected", {

  x <- c(1, 5, 5, 3)
  expect_identical(
    cumsum_threshold(x, 6),
    c(FALSE, TRUE, FALSE, TRUE)
  )

})
