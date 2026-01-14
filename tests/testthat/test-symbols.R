context("get")

test_that("id error messages", {
  expect_error(ntwd_get("wrong_id")) # probably backtickes or ? throws of an error about the msg
  expect_error(ntwd_get()) # same here
  expect_error(
    ntwd_get(c("monthly", "quarterly")),
    "trying to access multiple files"
  )
})

test_that("id works", {
  skip_if_offline()
  skip_if_http_error()

  expect_error(monthly <- ntwd_get("monthly", verbose = FALSE), NA)
  skip_if(is.null(monthly), "Data download failed (likely HTTP error)")

  expect_error(ntwd_get("quarterly", verbose = FALSE), NA)
  expect_error(ntwd_get("uk-house-price-since-1952", verbose = FALSE), NA)
  expect_error(ntwd_get("uk-house-prices-adjusted-for-inflation", verbose = FALSE), NA)
  expect_error(ntwd_get("seasonal-regional", verbose = FALSE), NA)
  expect_error(ntwd_get("new-prop", verbose = FALSE), NA)
  expect_error(ntwd_get("not-new-prop", verbose = FALSE), NA)
  expect_error(ntwd_get("first-by", verbose = FALSE), NA)
  expect_error(ntwd_get("fowner", verbose = FALSE), NA)
  expect_error(ntwd_get("terraced-post-1991", verbose = FALSE), NA)
  expect_error(ntwd_get("flats-post-1991", verbose = FALSE), NA)
  expect_error(ntwd_get("semi-detached-post-1991", verbose = FALSE), NA)
  expect_error(ntwd_get("detached-post-1991", verbose = FALSE), NA)
})

