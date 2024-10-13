
#' @importFrom httr RETRY
try_GET <- function(x, ...) {
  tryCatch(
    RETRY("GET", url = x, timeout(10),  quiet = TRUE,...),
    error = function(err) conditionMessage(err),
    warning = function(warn) conditionMessage(warn)
  )
}

is_response <- function(x) {
  class(x) == "response"
}

#' @importFrom httr GET write_disk timeout
#' @importFrom rvest html_nodes html_attrs
#' @importFrom xml2 read_html
ntwd_tf <- function(href, access_info = FALSE) {

  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  resp <- try_GET(href)
  if (!is_response(resp)) {
    message(resp)
    return(invisible(NULL))
  }
  if (httr::http_error(resp)) { # network is down = message (not an error anymore)
    httr::message_for_status(resp)
    return(invisible(NULL))
  }
  if (interactive() && access_info) {
    message("Accessing ", href)
  }
  tf <- tempfile(fileext = ".xlsx")
  resp_file <- try_GET(href, write_disk(tf))
  if (!is_response(resp_file)) {
    message(resp_file)
    return(invisible(NULL))
  }
  structure(tf, source = href, class = "access_url")
}

enclose <- function(x) {
  paste0("[", x, "]")
}

print.access_url <- function(x) {
  cat(enclose("Local file"), "\n\t", x, "\n")
  cat(enclose("Remote file:"), "\n\t", attr(x, "source"))
}
