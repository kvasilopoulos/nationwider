# url <- "https://www.nationwide.co.uk/about/house-price-index/download-data"
#
#
# library(rvest)
# library(xml2)
# library(readxl)
# library(dplyr)
# library(httr)
#
# paths <- xml2::read_html(url) %>%
#   rvest::html_nodes(".concertina") %>%
#   rvest::html_nodes("a") %>%
#   rvest::html_attr("href") %>%
#   grep(".xls", ., value = TRUE) %>%
#   paste0("https://www.nationwide.co.uk", .)
#
# # download <- function (category) {}
#
#
# tf <- tempfile(fileext = ".xls")
# httr::GET(paths[3], write_disk(tf))
#
#   # dplyr::mutate(Date = as.Date(...1), ...1 = NULL) %>%
#   # dplyr::select(Date, everything())
#
# readxl::read_excel(tf)
#
#
# xml2::read_html(url) %>%
#   rvest::html_nodes(".concertina") %>%
#   rvest::html_text(trim = TRUE) %>%
#   gsub("\r", "", .) %>%
#   gsub("\n", "", .) %>%
#   gsub(" ", "", .)
#
# file.remove(tf)

#' Fetch house price data fro Nationwide
#'
#'
#' \itemize{
#'  \item UK Series
#'    \describe{
#'      \item{\strong{monthly}}{UK Monthly Indices (Post '91) (This link will open in a new window)}
#'      \item{\emph{quarterly}}{First item}
#'    }
#' }
#'
#' \describe{
#'   \item{monthly}{UK Monthly Indices (Post '91)}
#'   \item{quarterly}{First item}
#'   \item{since-1952}{First item}
#'   \item{inflation-adjusted}{First item}
#'   \item{all-prop}{First item}
#'   \item{seasonal-regional}{First item}
#'   \item{new-prop}{First item}
#'   \item{mod-prop}{First item}
#'   \item{not-new-prop}{First item}
#'   \item{first-by}{First item}
#'   \item{fowner}{First item}
#'   \item{terraced}{First item}
#'   \item{flats}{First item}
#'   \item{semi-detached}{First item}
#'   \item{detached}{First item}
#'   \item{ftb-ind}{Affordability Estimates: First Time Buyer Affordability Indices}
#'   \item{ftb-hper}{Affordability Estimates: First Time Buyer House Price Earnings Ratios}
#' }
#' @name ntwd_dataset
#' @export
ntwd_dataset <- function() {}

#' @export
ntwd_get <- function(symbol) {

}
