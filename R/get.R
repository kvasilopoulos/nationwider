
# 5,7-16 same format ------------------------------------------------------

ntwd_get_symbol <- function(symbol) {
  if (missing(symbol)) {
    stop("You must specify a `symbol`, see ?nwtd_dataset", call. = FALSE)
  }
  symbol_categories <-
    c("monthly", "quarterly", "since_1952", "inflation_adjusted",
      "regional", "seasonal_regional",
      "new_prop", "mod_prop", "old_prop", "not_new_prop",
      "first","fowner",
      "terraced", "flats", "detached",
      "aftb_ind", "aftb_hper")

  if (!(symbol %in% symbol_categories)) {
    stop("`symbol` is not valid, see ?ntwd_dataset.", call. = FALSE)
  }
  switch(symbol,
     monthly = ntwd_get_monthly(),
     quarterly = ntwd_get_quarterly(),
     since_1952 = ntwd_get_since_1952(),
     inflation_adjusted = ntwd_get_inflation_adjusted(),
     regional = ntwd_get_generic("all_prop"),
     seasonal_regional = ntwd_get_seasonal_regional(),
     not_new_prop = ntwd_get_not_new_prop(),
     aftb_ind = ntwd_get_aftb_ind(),
     aftb_hper = ntwd_get_aftb_hper(),
     ntwd_get_generic(symbol)
  )
}

#' Access object's metadata
#'
#' Some datasets in nationwide contain metadata that cannot be displayed in
#' a dataframe, hence using \code{ntwd_meta} the grants access to the
#' object's metadata that are stored as attributes to the dataframe.
#'
#' @param x object return from \code{\link{ntwd_get}}
#'
#' @details Not all objects contain metadata
#'
#' @export
#' @examples
#' x <- ntwd_get("since_1952")
#' ntwd_meta(x)
ntwd_meta <- function(x) {
  attr(x, "metadata") %||%
    message("the objects does not contain metadata")
}


#' Download house price data from Nationwide
#'
#' \code{\link{ntwd_dataset}}
#'
#' @param symbol which dataset symbol to fetch.
#'
#' @export
ntwd_get <- function(symbol) {
  ntwd_get_symbol(symbol)
}

