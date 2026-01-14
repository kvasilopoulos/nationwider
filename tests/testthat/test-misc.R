context("misc")

test_that("browse url", {
  skip_if(interactive()) # to avoid opening tabs
  expect_identical(
    ntwd_browse(),
    "https://www.nationwide.co.uk/about/house-price-index/headlines"
  )
})


test_that("access meta", {
  skip_if_offline()
  skip_if_http_error()

  tbl <- ntwd_get("uk-house-price-since-1952", verbose = FALSE)
  skip_if(is.null(tbl), "Data download failed (likely HTTP error)")
  expect_identical(ntwd_meta(tbl), "1952 Q4 = 100")

  tbl2 <- ntwd_get("seasonal-regional", verbose = FALSE)
  skip_if(is.null(tbl2), "Data download failed (likely HTTP error)")
  expect_message(ntwd_meta(tbl2), "the object does not contain metadata")
})
