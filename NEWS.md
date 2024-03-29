
# nationwider 1.1.2

* use `RETRY` is http requests as per best practice
* Capitalized properly `UK` in region names

# nationwider 1.1.1

## New Features

* `ntwd_get` now prints the url of the sourced excel file. Option can be
skipped if `verbose` argument is set to `FALSE`.

## Bug Fixes

* Adjusted functions to gracefully fail (all errors are demoted to messages) if:
  - There is no internet
  - http error status
  - Timeout error
  
* Fixed row subassignment after tibble 1.0.0. update.

# nationwider 1.1.0

* Added a `NEWS.md` file to track changes to the package.

## Bug Fixes

* Added `semi-det` to the list of available ids
* Fixed NA name in ntwd_get("seasonal_regional"), since the coming update of tidyselect 1.0 which performs stronger name checking (#1).

## New Features

`ntwd_get(id, verbose)`

* Now prints the excel source
* Argument verbose can disable printing

## Minor improvements

* Renamed column `key` to `type/house_type`

# nationwider 1.0.0

* Initial release

