context("cumall")


test_that("cumall works as expected", {
  expect_true(all(is.na(cumall(rep(NA, 5)))))
  expect_true(all(cumall(rep(TRUE, 5))))
  expect_false(any(cumall(rep(FALSE, 5))))

  expect_identical(
    cumall(c(TRUE, TRUE, TRUE, FALSE)),
    c(TRUE, TRUE, TRUE, FALSE)
  )

  expect_identical(
    cumall(c(TRUE, TRUE, FALSE, TRUE)),
    c(TRUE, TRUE, FALSE, FALSE)
  )

  expect_identical(
    cumall(c(TRUE, TRUE, NA, FALSE, NA)),
    c(TRUE, TRUE, NA, FALSE, FALSE)
  )
})


test_that("cumany works as expected", {

  skip("not yet")

  expect_identical(
    cumany(c(TRUE, NA, FALSE)),
    c(TRUE, TRUE, TRUE)
  )

  expect_identical(
    cumany(c(FALSE, NA, TRUE)),
    c(FALSE, NA, TRUE)
  )

})
