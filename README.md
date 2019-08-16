
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nationwider

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/nationwider)](https://CRAN.R-project.org/package=nationwider)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis build
status](https://travis-ci.org/kvasilopoulos/nationwider.svg?branch=master)](https://travis-ci.org/kvasilopoulos/nationwider)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/kvasilopoulos/nationwider?branch=master&svg=true)](https://ci.appveyor.com/project/kvasilopoulos/nationwider)
[![Codecov test
coverage](https://codecov.io/gh/kvasilopoulos/nationwider/branch/master/graph/badge.svg)](https://codecov.io/gh/kvasilopoulos/nationwider?branch=master)
<!-- badges: end -->

The goal of nationwider is to …

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kvasilopoulos/nationwider")
```

## Example

This is a basic example on how to download data with {nationwider}.

``` r
library(nationwider)
## basic example code
nationwider::ntwd_get("monthly")
#> # A tibble: 343 x 7
#>    Date       `Average House ~ `INDEX Q1 1993=~ `Seasonally Adj~
#>    <date>                <dbl>            <dbl>            <dbl>
#>  1 1991-01-01           53052.             106.             107.
#>  2 1991-02-01           53497.             107.             107.
#>  3 1991-03-01           52893.             106.             107.
#>  4 1991-04-01           53677.             107.             107.
#>  5 1991-05-01           54386.             108.             107.
#>  6 1991-06-01           55107.             110.             108.
#>  7 1991-07-01           54541.             109.             107.
#>  8 1991-08-01           54041.             108.             107.
#>  9 1991-09-01           53259.             106.             107.
#> 10 1991-10-01           53467.             107.             107.
#> # ... with 333 more rows, and 3 more variables: `Monthly % Change
#> #   (SA)` <dbl>, `Year % Change` <dbl>, `Latest 3 months on previous 3
#> #   months` <dbl>
```
