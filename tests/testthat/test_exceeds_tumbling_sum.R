test_that("cumsum_threshold works as expected", {

  x <- c(1, 5, 5, 3)
  expect_identical(
    exceeds_tumbling_sum(x, 6),
    c(FALSE, TRUE, FALSE, TRUE)
  )

  expect_identical(
    exceeds_tumbling_sum(x, 6),
    exceeds_tumbling_sum(as.integer(x), 6L)
  )


})
