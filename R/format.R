
# silent excel ------------------------------------------------------------

#' @importFrom readxl read_excel
read_excel_silently <- function(...) {
  suppressMessages({
    readxl::read_excel(..., na = c("", "N/A"))
  })
}

read_excel_silently_ <- function(...) {
  suppressMessages({
    readxl::read_excel(...)
  })
}

# get ---------------------------------------------------------------------


#' @importFrom zoo na.locf
#' @importFrom dplyr mutate transmute_all mutate_if slice rename_all full_join n
#' @importFrom tidyr gather
#' @importFrom magrittr set_names
#' @importFrom lubridate is.Date yq
ntwd_get_generic <- function(symbol) {
  num <- grep(gsub("_", "-", symbol), ntwd_tf(NULL))
  xfile <- ntwd_tf(num[1])
  x <- read_excel_silently(xfile, skip = 0, n_max = 3, col_names = FALSE)
  x[1,] <- zoo::na.locf(unlist(x[1,])) %>% char_na()
  x[2,] <- char_na(x[2,])
  x[3,] <- gsub("\u00A3", " \u00A3", x[3,]) %>% gsub("INDEX", ": INDEX", .) %>% char_na()
  nms <- transmute_all(x, paste, collapse = " ") %>%
    slice(2) %>%  unlist(use.names = FALSE) %>% gsub("^: ", "", .) %>%
    trimws() %>% gsub("\\s+"," ",.)  %>% gsub(" :", ":", .)
  read_excel_silently(xfile, skip = 3, col_names = FALSE) %>%
    clean_date_qy() %>%
    set_names(nms) %>%
    mutate_if(Negate(lubridate::is.Date), as.double)
}


ntwd_get_monthly <- function() {
  ntwd_tf(1) %>%
    read_excel_silently(.) %>%
    clean_date()
}

ntwd_get_quarterly <- function() {
  ntwd_tf(2) %>%
    read_excel_silently(.) %>%
    clean_date_qy()
}

ntwd_get_since_1952 <- function() {
  xfile <- ntwd_tf(3)
  x <- read_excel_silently(xfile, skip = 3, n_max = 3, col_names = FALSE)
  x[1,] <- c("", zoo::na.locf(unlist(x[1,])))
  x[2,] <- paste0(": ", x[2,])
  x[3,] <- paste0(" (", x[3,], ")")

  nms <- transmute_all(x, paste, collapse = "") %>%
    slice(2) %>%  unlist(use.names = FALSE) %>%
    gsub("^: ", "", .) %>% gsub("(NA)", "", ., fixed = TRUE) %>% trimws()
  read_excel_silently_(xfile, skip = 6, col_names = FALSE,
                      na = c("", "Series discontinued")) %>%
    clean_date_qy() %>%
    set_names(nms) %>%
    mutate_if(Negate(lubridate::is.Date), as.double)
}

ntwd_get_inflation_adjusted <- function() {
  xfile <- ntwd_tf(4)
  skip_after <- read_excel_silently(xfile) %>% trunc_na() %>% nrow()
  read_excel_silently(xfile, n_max = skip_after) %>%
    clean_date_yq() %>%
    rename_all(list(~ gsub("\\s*\\([^\\)]+\\)","",.)))
}

ntwd_get_seasonal_regional <- function() {
  xfile6 <- ntwd_tf(6)
  x <- read_excel_silently(xfile6, skip = 0, n_max = 3)
  x <- x[-2,]
  x[1,] <- c(NA, zoo::na.locf(unlist(x[1,]))) %>% char_na()
  nms <- transmute_all(x, paste, collapse = " ") %>%
    slice(2) %>%  unlist(use.names = FALSE) %>%
    gsub("^: ", "", .) %>% trimws()
  read_excel_silently(xfile6, skip = 3, col_names = FALSE) %>%
    clean_date_qy() %>%
    set_names(nms)
}

ntwd_get_not_new_prop <- function() {
  xfile <- ntwd_tf(10)
  nms <- c("Date", "UK Not new (\u00A3)")
  read_excel_silently(xfile, skip = 3, col_types = c("text", "text", "skip"),
                      col_names = FALSE) %>%
    clean_date_qy() %>%
    set_names(nms) %>%
    mutate_if(Negate(lubridate::is.Date), as.double)
}

ntwd_get_aftb_ind <- function() {
  xfile17 <- ntwd_tf(17)
  percent <- read_excel_silently(xfile17, skip = 3) %>%
    clean_date_yq() %>%
    mutate(type = "percentage") %>%
    gather(region, value, -Date, -type)
  index <- read_excel_silently(xfile17, skip = 3, sheet = 2) %>%
    clean_date_yq() %>%
    mutate(type = "index") %>%
    gather(region, value, -Date, -type)
  full_join(percent, index, by = c("Date", "type", "region", "value"))
}

ntwd_get_aftb_hper <- function() {
  ntwd_tf(18) %>%
    read_excel_silently(.) %>%
    clean_date_yq()
}
