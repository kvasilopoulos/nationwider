
# 5,7-16 same format ------------------------------------------------------

avail_ids <- function() {
  ntwd_dataset$id
}

# Backward compatibility mapping for old underscore-based IDs
translate_legacy_id <- function(id) {
  legacy_map <- c(
    "since_1952" = "uk-house-price-since-1952",
    "inflation_adjusted" = "uk-house-prices-adjusted-for-inflation",
    "seasonal_regional" = "seasonal-regional",
    "new_prop" = "new-prop",
    "not_new_prop" = "not-new-prop",
    "first" = "first-by",
    "terraced" = "terraced-post-1991",
    "flats" = "flats-post-1991",
    "semi_det" = "semi-detached-post-1991",
    "detached" = "detached-post-1991"
  )

  if (id %in% names(legacy_map)) {
    return(legacy_map[[id]])
  }
  return(id)
}

ntwd_get_id <- function(id, .verbose) {

  if (missing(id)) {
    stop("You must specify a `id`, see `avail_ids()`", call. = FALSE)
  }
  if (length(id) > 1) {
    stop("trying to access multiple files", call. = FALSE)
  }

  # Translate legacy IDs for backward compatibility
  id <- translate_legacy_id(id)

  if (!(id %in% avail_ids())) {
    stop("`id` is not valid, see ?ntwd_dataset.", call. = FALSE)
  }
  id_flat <- gsub("-", "_", id)
  resp  <- tryCatch(expr = {
    switch(
      id_flat,
      monthly = ntwd_get_monthly(.access_info = .verbose),
      quarterly = ntwd_get_quarterly(.access_info = .verbose),
      uk_house_price_since_1952 = ntwd_get_since_1952(.access_info = .verbose),
      uk_house_prices_adjusted_for_inflation = ntwd_get_inflation_adjusted(.access_info = .verbose),
      # all_buyers_hper_by_region = ntwd_get_generic("all-buyers-hper-by-region", .access_info = .verbose),
      seasonal_regional = ntwd_get_seasonal_regional(.access_info = .verbose),
      # not_new_prop = ntwd_get_not_new_prop(.access_info = .verbose),
      ntwd_get_generic(id, .access_info = .verbose)
    )
  },
  error = function(err) conditionMessage(err),
  warning = function(warn) conditionMessage(warn)
  )
  # if (!is_response(resp)) {
  #   message(resp)
  #   return(invisible(NULL))
  # }
  # if (httr::http_error(resp)) { # network is down = message (not an error anymore)
  #   httr::message_for_status(resp)
  #   return(invisible(NULL))
  # }
  resp
}

#' Access object's metadata
#'
#' Some datasets in nationwide contain metadata that cannot be displayed in
#' a dataframe. All metadata are stored as attributes to the dataframe, where it
#' can be displayed with \code{ntwd_meta}.
#'
#' @param x The object that is returned from \code{\link{ntwd_get}}.
#'
#' @details Not all objects contain metadata
#'
#' @return A character vector.
#'
#' @export
#'
#' @examples
#' \donttest{
#' x <- ntwd_get("uk-house-price-since-1952")
#' ntwd_meta(x)
#' }
ntwd_meta <- function(x) {
  attr(x, "metadata") %||%
    message("the object does not contain metadata")
}


#' Download House Price Data from Nationwide
#'
#' This function scrapes Nationwide's House Price Index webpage and
#' downloads data in tidy format. Available datasets are given an `id`. All
#' available `id` and short descriptions  can be viewed via `?datasets`.
#' For more information the user can browse the source webpage through
#' \code{\link{ntwd_browse}}.
#'
#' @param id which `id`to fetch. See `?ntwd_dataset` for a full list.
#' @param verbose whether to print the url of the data.
#'
#' @return Returns a tibble.
#'
#' @export
#'
#' @examples
#'\donttest{
#' ntwd_get("monthly")
#' ntwd_get("uk-house-price-since-1952")
#'
#' # For a list of datasets
#' ?ntwd_datasets
#' }
ntwd_get <- function(id, verbose = TRUE) {
  ntwd_get_id(id, .verbose = verbose)
}

