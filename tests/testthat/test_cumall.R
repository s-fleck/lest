context("cumall")


test_that("cumall works as expected", {

  # normal usecases
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

  expect_identical(
    cumall(c(TRUE, NA, TRUE, FALSE)),
    c(TRUE, NA, NA, FALSE)
  )

  # NAs
  expect_true(all(is.na(cumall(rep(NA, 5)))))
  expect_true(all(cumall(rep(TRUE, 5))))
  expect_false(any(cumall(rep(FALSE, 5))))


  # n = 1
  expect_true(is.na(cumall(NA)))
  expect_true(cumall(TRUE))
  expect_false(cumall(FALSE))

  # n = 0
  expect_identical(
    cumall(logical()),
    logical()
  )
})




test_that("cumany works as expected", {

  # normal usecases
  expect_identical(
    cumany(c(TRUE, NA, FALSE)),
    c(TRUE, TRUE, TRUE)
  )

  expect_identical(
    cumany(c(FALSE, NA, TRUE)),
    c(FALSE, NA, TRUE)
  )

  # NAs
  expect_true(all(is.na(cumany(rep(NA, 5)))))
  expect_true(all(cumany(rep(TRUE, 5))))
  expect_false(any(cumany(rep(FALSE, 5))))

  # n = 1
  expect_true(is.na(cumany(NA)))
  expect_true(cumany(TRUE))
  expect_false(cumany(FALSE))

  # n = 0
  expect_identical(
    cumany(logical()),
    logical()
  )

})
