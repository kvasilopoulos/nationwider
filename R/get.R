#' Available Datasets
#'
#' These are the datasets available from \url{https://www.nationwide.co.uk}. For more details
#' you can see \href{https://www.nationwide.co.uk/about/house-price-index/download-data#~}{Nationwide}.
#'
#' \itemize{
#'  \item UK Series
#'    \itemize{
#'      \item \code{monthly}: UK Monthly Indices (Post '91)
#'      \item \code{quarterly}: UK Quarterly Indices (Post '91)
#'      \item \code{since_1952}: UK House Prices Since 1952
#'      \item \code{inflation_adjusted}: UK House Prices Adjusted for Inflation
#'    }
#'  \item UK & regional quarterly series – all properties (data available from 1973 onwards)
#'   \itemize{
#'      \item \code{regional}: Regional Quarterly Indices (Post '73)
#'      \item \code{seasonal_regional}: Seasonally Adjusted Regional Quarterly Indices

#'    }
#'  \item UK & regional quarterly series - by property age group (data available from 1973 onwards)
#'   \itemize{
#'     \item \code{new_prop}: New Properties (Post '73)
#'     \item \code{mod_prop}: Modern Properties (Post '73) - discontinued
#'     \item \code{old_prop}: Older Properties (Post '73) - discontinued
#'     \item \code{not_new_prop}: Not New Properties (Post '95)
#'    }
#'  \item UK & regional quarterly series - by buyer type (data available from 1983 onwards)
#'   \itemize{
#'      \item \code{first}: First Time Buyer (Post '83)
#'      \item \code{fowner}: Former Owner Occupier (Post '83)
#'    }
#'  \item UK & regional quarterly series - by property type (data available from 1991 onwards; regional data ends Q2 2015, UK only thereafter)
#'   \itemize{
#'     \item \code{terraced}: Terraced (Post '91)
#'     \item \code{flats}: Flats (Post '91)
#'     \item \code{semi_detached}: Semi Detached (Post '91)
#'     \item \code{detached}: Detached (Post '91)
#'    }
#'  \item Affordability Estimates
#'   \itemize{
#'      \item \code{aftb_ind}: First Time Buyer Affordability Indices
#'      \item \code{aftb_hper}: First Time Buyer House Price Earnings Ratios
#'    }
#' }
#'
#'
#' @name ntwd_dataset
NULL

# 5,7-16 same format ------------------------------------------------------

ntwd_get_symbol <- function(symbol) {
  symbol_categories <-
    c("monthly", "quarterly", "since_1952", "inflation_adjusted",
      "regional", "seasonal_regional",
      "new_prop", "mod_prop", "old_prop", "not_new_prop",
      "first","fowner",
      "terraced", "flats", "detached",
      "aftb_ind", "aftb_hper")
  if (!(symbol %in% symbol_categories)) {
    stop("symbol is not valid, see ?ntwd_dataset.", call. = FALSE)
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
