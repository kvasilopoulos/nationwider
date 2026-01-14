## code to prepare `DATASET` dataset goes here

library(httr)
library(rvest)
library(dplyr)
library(tibble)

baseurl <- "https://www.nationwide.co.uk/media/hpi"
category_a <- read_html(paste0(baseurl, "/resources/")) %>%
  html_nodes("a")
category_href <- html_attr(category_a, "href")

category_idx <- grep("resources/f", category_href)
category_id <- gsub(".*/f/(.+)$", "\\1", category_href[category_idx])
category_desc <- html_text(category_a)[category_idx] %>%
  trimws() %>%
  gsub("\\n.*", "", .)

subcategories <- list()
for(i in 1:length(category_id)) {
  a <- read_html(paste0(baseurl, "/resources/f/", category_id[i])) %>%
    html_nodes("a")
  class_a <- html_attr(a, "class")
  idx <- which(class_a %in% "item-link")

  # Skip if no items found
  if(length(idx) == 0) next

  href <- html_attr(a, "href")[idx]
  id <- gsub(".*/download/(.+)$", "\\1", href)
  desc <- trimws(html_text(a)[idx])
  # href already contains /media/hpi/download/..., just need the base domain
  full_href <- ifelse(grepl("^/", href),
                      paste0("https://www.nationwide.co.uk", href),
                      href)
  subcategories[[i]] <- tibble(id = id,  desc = desc, href = full_href)
}
names(subcategories) <- paste0(category_desc," 0 ", category_id)
ntwd_dataset <- bind_rows(subcategories, .id = "category") %>%
  tidyr::separate(col = "category", into = c("category_desc", "category_id"), sep = "0") %>%
  mutate(category_desc = trimws(category_desc)) %>%
  distinct(id, .keep_all = TRUE)

usethis::use_data(ntwd_dataset, overwrite = TRUE, internal = TRUE)


