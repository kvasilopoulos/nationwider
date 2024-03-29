
# 5,7-16 same format ------------------------------------------------------

avail_ids <- function() {
  ntwd_dataset$id
}

ntwd_get_id <- function(id, .verbose) {

  if (missing(id)) {
    stop("You must specify a `id`, see `avail_ids()`", call. = FALSE)
  }
  if (length(id) > 1) {
    stop("trying to access multiple files", call. = FALSE)
  }
  ids <-
    c("monthly", "quarterly", "since_1952", "inflation_adjusted",
      # "regional",
      "seasonal_regional"#,
      # # "new_prop", "mod_prop", "old_prop", "not_new_prop",
      # "first","fowner",
      # "terraced", "flats", "semi_det", "detached",
      # "aftb_ind", "aftb_hper"
    )
  if (!(id %in% ids)) {
    stop("`id` is not valid, see ?ntwd_dataset.", call. = FALSE)
  }

  resp  <- tryCatch(expr = {
    switch(
      id,
      monthly = ntwd_get_monthly(.access_info = .verbose),
      quarterly = ntwd_get_quarterly(.access_info = .verbose),
      since_1952 = ntwd_get_since_1952(.access_info = .verbose),
      inflation_adjusted = ntwd_get_inflation_adjusted(.access_info = .verbose),
      # regional = ntwd_get_generic("all-buyers-hper-by-region", .access_info = .verbose),
      seasonal_regional = ntwd_get_seasonal_regional(.access_info = .verbose)#,
      # not_new_prop = ntwd_get_not_new_prop(.access_info = .verbose),
      # aftb_ind = ntwd_get_aftb_ind(.access_info = .verbose),
      # aftb_hper = ntwd_get_aftb_hper(.access_info = .verbose),
      # ntwd_get_generic(id, .access_info = .verbose)
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
#' x <- ntwd_get("since_1952")
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
#'
#' # For a list of datasets
#' ?ntwd_datasets
#' }
ntwd_get <- function(id, verbose = TRUE) {
  ntwd_get_id(id, .verbose = verbose)
}

