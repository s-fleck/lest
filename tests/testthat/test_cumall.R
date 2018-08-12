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

  # scalars
  expect_true(is.na(cumall(NA)))
  expect_true(cumall(TRUE))
  expect_false(cumall(FALSE))

  # degenerate cases
  expect_identical(
    cumall(logical()),
    logical()
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

  # scalars
  expect_true(is.na(cumany(NA)))
  expect_true(cumany(TRUE))
  expect_false(cumany(FALSE))

  # degenerate cases
  expect_identical(
    cumany(logical()),
    logical()
  )

})
