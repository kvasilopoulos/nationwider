#' @importFrom httr GET write_disk timeout
#' @importFrom rvest html_nodes html_attrs
#' @importFrom xml2 read_html
ntwd_tf <- function(file = NULL, regexp = NULL, access_info = FALSE) {

  dl_url <- "https://www.nationwide.co.uk/about/house-price-index/download-data"
  con_url <- GET(dl_url, timeout(10))

  urls <-
    xml2::read_html(con_url) %>%
    rvest::html_nodes(".concertina") %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    grep(".xls", ., value = TRUE) %>%
    paste0("https://www.nationwide.co.uk", .)

  if (is.null(file) && is.null(regexp)) {
    return(urls)
  }
  if (!is.null(file)) {
    url <- magrittr::extract(urls, file)
  }
  if (!is.null(regexp)) {
    url <- grep(regexp, urls, value = TRUE)
  }
  if (length(url) > 1) {
    stop("trying to access multiple files", call. = FALSE)
  }
  if (interactive() && access_info)
    message("Accessing ", url)
  tf <- tempfile(fileext = ".xls")
  GET(url, write_disk(tf), timeout(10))
  structure(tf, source = url, class = "access_url")
}

enclose <- function(x) {
  paste0("[", x, "]")
}

print.access_url <- function(x) {
  cat(enclose("Local file"), "\n\t", x, "\n")
  cat(enclose("Remote file:"), "\n\t", attr(x, "source"))
}
