context("tidy")

test_that("tidy objects", {
  skip_if_offline()
  skip_if_http_error()

  expect_tidy(ntwd_get("monthly", verbose = FALSE))
  expect_tidy(ntwd_get("quarterly", verbose = FALSE))
  expect_tidy(ntwd_get("uk-house-price-since-1952", verbose = FALSE))
  expect_tidy(ntwd_get("uk-house-prices-adjusted-for-inflation", verbose = FALSE))
  expect_tidy(ntwd_get("seasonal-regional", verbose = FALSE))
  expect_tidy(ntwd_get("new-prop", verbose = FALSE))
  expect_tidy(ntwd_get("first-by", verbose = FALSE))
  expect_tidy(ntwd_get("fowner", verbose = FALSE))
  expect_tidy(ntwd_get("terraced-post-1991", verbose = FALSE))
  expect_tidy(ntwd_get("flats-post-1991", verbose = FALSE))
  expect_tidy(ntwd_get("semi-detached-post-1991", verbose = FALSE))
  expect_tidy(ntwd_get("detached-post-1991", verbose = FALSE))
  # not-new-prop has long format, not tidy
})



# test_that("UK is capital", {
#   expect_true("UK" %in% unique(ntwd_get("mod_prop")$region))
#   expect_true("UK" %in% unique(ntwd_get("regional")$region))
# })
