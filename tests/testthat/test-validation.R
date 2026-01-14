context("validation")

test_that("avail_ids returns character vector", {
  ids <- nationwider:::avail_ids()
  expect_type(ids, "character")
  expect_true(length(ids) > 0)
  expect_true(all(nchar(ids) > 0))
})

test_that("id_to_href returns valid URLs", {
  test_ids <- c("monthly", "quarterly", "seasonal-regional")
  for (id in test_ids) {
    href <- nationwider:::id_to_href(id)
    expect_type(href, "character")
    expect_match(href, "^https://")
    expect_match(href, "nationwide\\.co\\.uk")
    expect_match(href, "/download/")
  }
})

test_that("dataset has required columns", {
  expect_true(exists("ntwd_dataset", where = asNamespace("nationwider")))
  dataset <- get("ntwd_dataset", envir = asNamespace("nationwider"))
  expect_true("id" %in% names(dataset))
  expect_true("desc" %in% names(dataset))
  expect_true("href" %in% names(dataset))
  expect_true("category_desc" %in% names(dataset))
  expect_true("category_id" %in% names(dataset))
})

test_that("dataset has no duplicate IDs", {
  dataset <- get("ntwd_dataset", envir = asNamespace("nationwider"))
  expect_false(anyDuplicated(dataset$id) > 0)
})

test_that("all dataset URLs are well-formed", {
  dataset <- get("ntwd_dataset", envir = asNamespace("nationwider"))
  expect_true(all(grepl("^https://", dataset$href)))
  expect_true(all(grepl("/download/", dataset$href)))
})

test_that("key IDs exist in dataset", {
  ids <- nationwider:::avail_ids()
  required_ids <- c("monthly", "quarterly", "seasonal-regional",
                    "uk-house-price-since-1952",
                    "uk-house-prices-adjusted-for-inflation")
  for (rid in required_ids) {
    expect_true(rid %in% ids,
                info = paste("Required ID", rid, "not found in dataset"))
  }
})

test_that("ntwd_meta handles missing metadata", {
  mock_data <- data.frame(Date = as.Date("2020-01-01"), value = 1)
  expect_message(ntwd_meta(mock_data), "does not contain metadata")
})

test_that("ntwd_meta returns metadata when present", {
  mock_data <- data.frame(Date = as.Date("2020-01-01"), value = 1)
  attr(mock_data, "metadata") <- "Test metadata"
  expect_identical(ntwd_meta(mock_data), "Test metadata")
})

test_that("date cleaning functions exist", {
  # Test that the date cleaning functions exist
  expect_true(exists("clean_date", where = asNamespace("nationwider")))
  expect_true(exists("clean_date_yq", where = asNamespace("nationwider")))
  expect_true(exists("clean_date_qy", where = asNamespace("nationwider")))
})

test_that("helper functions exist and work", {
  # Test set_source
  mock_url <- structure("test.xlsx", source = "http://example.com",
                       class = "access_url")
  mock_tbl <- data.frame(x = 1:3)
  result <- nationwider:::set_source(mock_tbl, mock_url)
  expect_equal(attr(result, "source"), "http://example.com")

  # Test char_na function exists
  expect_true(exists("char_na", where = asNamespace("nationwider")))
})
