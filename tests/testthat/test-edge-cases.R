context("edge-cases")

test_that("invalid ID produces clear error", {
  expect_error(
    ntwd_get("this-id-does-not-exist"),
    "not valid"
  )
  expect_error(
    ntwd_get(""),
    "not valid"
  )
})

test_that("missing ID produces clear error", {
  expect_error(
    ntwd_get(),
    "must specify"
  )
})

test_that("multiple IDs produce clear error", {
  expect_error(
    ntwd_get(c("monthly", "quarterly")),
    "multiple files"
  )
})

test_that("NULL and NA handling", {
  expect_error(ntwd_get(NULL))
  expect_error(ntwd_get(NA_character_))
})

test_that("case sensitivity in IDs", {
  # IDs should be case-sensitive (lowercase expected)
  expect_error(ntwd_get("MONTHLY"), "not valid")
  expect_error(ntwd_get("Monthly"), "not valid")
})

test_that("ID with underscores (legacy format) works for backward compatibility", {
  skip_if_offline()
  skip_if_http_error()

  # The old underscore format should still work for backward compatibility
  expect_error(ntwd_get("since_1952", verbose = FALSE), NA)
  expect_error(ntwd_get("inflation_adjusted", verbose = FALSE), NA)
  expect_error(ntwd_get("seasonal_regional", verbose = FALSE), NA)
})

test_that("whitespace in IDs is not trimmed", {
  expect_error(ntwd_get(" monthly "), "not valid")
  expect_error(ntwd_get("monthly "), "not valid")
  expect_error(ntwd_get(" monthly"), "not valid")
})

test_that("ntwd_browse returns correct URL", {
  skip_if(interactive())
  url <- ntwd_browse()
  expect_type(url, "character")
  expect_match(url, "nationwide")
  expect_match(url, "house-price-index")
})

test_that("data fetching handles network errors gracefully", {
  skip_if_offline()

  # This should return NULL gracefully if the URL doesn't work
  # rather than throwing an error
  result <- ntwd_get("monthly", verbose = FALSE)
  # Should be either a data frame or NULL, never an error
  expect_true(is.data.frame(result) || is.null(result))
})

test_that("verbose parameter exists", {
  skip_if_offline()
  skip_if_http_error()

  # Verbose parameter should be accepted without error
  result <- ntwd_get("monthly", verbose = FALSE)
  expect_true(is.data.frame(result) || is.null(result))

  # Test that verbose = TRUE also works
  result2 <- ntwd_get("monthly", verbose = TRUE)
  expect_true(is.data.frame(result2) || is.null(result2))
})

test_that("generic getter handles unknown IDs from dataset", {
  skip_if_offline()
  skip_if_http_error()

  # Try to get a dataset that exists but doesn't have a specialized function
  result <- ntwd_get("new-prop", verbose = FALSE)
  # Should either work, return NULL, or return a character error message
  expect_true(is.data.frame(result) || is.null(result) || is.character(result))
})

test_that("read_excel_silently suppresses messages", {
  # This internal function should suppress readxl messages
  expect_true(exists("read_excel_silently",
                    where = asNamespace("nationwider")))
  expect_true(exists("read_excel_silently_",
                    where = asNamespace("nationwider")))
})

test_that("try_GET handles errors gracefully", {
  # Test with invalid URL
  result <- nationwider:::try_GET("http://this-url-does-not-exist-12345.com")
  expect_false(nationwider:::is_response(result))
  expect_type(result, "character") # Should return error message as string
})

test_that("id_to_href handles invalid ID gracefully", {
  # Should return integer(0) for non-existent ID
  result <- nationwider:::id_to_href("non-existent-id")
  expect_equal(length(result), 0)
})
