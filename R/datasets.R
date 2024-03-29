#' Available Datasets
#'
#' These are the datasets available from \url{https://www.nationwide.co.uk}. For more details
#' you can see use \code{\link{ntwd_browse}} to browse Nationwide's House Price Index webpage.
#'
#' @details
#' The formatted text before the semicolon indicates the `id `that is used to get
#' the data through \code{\link{ntwd_get}}. After the semicolon there is a short description
#' provided by nationwide.
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
#'     \item \code{semi_det}: Semi Detached (Post '91)
#'     \item \code{detached}: Detached (Post '91)
#'    }
#'  \item Affordability Estimates
#'   \itemize{
#'      \item \code{aftb_ind}: First Time Buyer Affordability Indices
#'      \item \code{aftb_hper}: First Time Buyer House Price Earnings Ratios
#'    }
#' }
#'
#' @name ntwd_dataset
#' @aliases ntwd_datasets
NULL







