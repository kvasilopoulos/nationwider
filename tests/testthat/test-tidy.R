context("tidy")

has_date <- function(x) {
  first <- x[, 1, drop = TRUE]
  lubridate::is.Date(first) && names(x)[1] == "Date"
}

has_proper_names <- function(x) {
  names(x)[-1] %in% c("region", "type", "key", "value")
}

is_tidy <- function(x) {
  has_date(x) && has_proper_names(x)
}

expect_tidy <- function(x) {
  expect(is_tidy(x), "object is not tidy")
}

test_that("tidy objects", {
  expect_tidy(ntwd_get("monthly"))
  expect_tidy(ntwd_get("quarterly"))
  expect_tidy(ntwd_get("since_1952"))
  expect_tidy(ntwd_get("inflation_adjusted"))
  expect_tidy(ntwd_get("regional"))
  expect_tidy(ntwd_get("seasonal_regional"))
  expect_tidy(ntwd_get("new_prop"))
  expect_tidy(ntwd_get("mod_prop"))
  expect_tidy(ntwd_get("old_prop"))
  # ntwd_get("not_new_prop") # except this one
  expect_tidy(ntwd_get("first"))
  expect_tidy(ntwd_get("fowner"))
  expect_tidy(ntwd_get("terraced"))
  expect_tidy(ntwd_get("flats"))
  expect_tidy(ntwd_get("detached"))
  expect_tidy(ntwd_get("aftb_ind"))
  expect_tidy(ntwd_get("aftb_hper"))
})



