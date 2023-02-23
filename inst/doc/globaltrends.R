## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, eval = FALSE------------------------------------------------------
#  # install package --------------------------------------------------------------
#  # current cran version
#  install.packages("globaltrends")
#  # current dev version
#  devtools::install_github("ha-pu/globaltrends", build_vignettes = TRUE)
#  
#  # load package -----------------------------------------------------------------
#  library(globaltrends)
#  
#  # package version --------------------------------------------------------------
#  packageVersion("globaltrends")
#  #> [1] '0.0.12'

## ---- eval = FALSE------------------------------------------------------------
#  # initialize_db ----------------------------------------------------------------
#  setwd("your/globaltrends/folder")
#  initialize_db()
#  #> Database has been created.
#  #> Table 'batch_keywords' has been created.
#  #> ...
#  #> Table 'data_global' has been created.
#  #> Successfully disconnected.

## ---- eval = FALSE------------------------------------------------------------
#  # start_db ---------------------------------------------------------------------
#  setwd("your/globaltrends/folder")
#  start_db()
#  #> Successfully connected to database.
#  #> Successfully exported all objects to .GlobalEnv.
#  print(ls())
#  #>  [1] "batch_keywords"   "batch_time"       "countries"        "data_control"
#  #>  [5] "data_doi"         "data_global"      "data_locations"   "data_mapping"
#  #>  [9] "data_object"      "data_score"       "dir_current"      "dir_wd"
#  #> [13] "globaltrends_db"  "keyword_synonyms" "keywords_control" "keywords_object"
#  #> [17] "time_control"     "time_object"      "us_states"

## ---- eval = FALSE------------------------------------------------------------
#  # disconnect_db ----------------------------------------------------------------
#  disconnect_db()
#  #> Successfully disconnected.

## ---- eval = FALSE------------------------------------------------------------
#  # add_control_keyword ----------------------------------------------------------
#  new_control <- add_control_keyword(
#    keyword = c("gmail", "maps", "translate", "wikipedia", "youtube"),
#    time = "2010-01-01 2020-12-31"
#  )
#  #> Successfully created new control batch 1 (gmail ... youtube, 2010-01-01 2020-12-31).

## ---- eval = FALSE------------------------------------------------------------
#  # keywords_control and dplyr interaction ---------------------------------------
#  dplyr::filter(keywords_control, keyword == "gmail")
#  #> # A tibble: 1 x 2
#  #>   batch keyword
#  #>   <int> <chr>
#  #> 1     1 gmail

## ---- eval = FALSE------------------------------------------------------------
#  # download_control -------------------------------------------------------------
#  download_control(control = new_control, locations = countries)
#  #> Successfully downloaded control data | control: 1 | location: US [1/66]
#  #> ...
#  #> Successfully downloaded control data | control: 1 | location: DO [66/66]

## ---- eval = FALSE------------------------------------------------------------
#  # download_control_global ------------------------------------------------------
#  download_control_global(control = new_control)
#  #> Successfully downloaded control data | control: 1 | location: world [1/1]

## ---- eval = FALSE------------------------------------------------------------
#  # add_object_keyword -----------------------------------------------------------
#  new_object <- add_object_keyword(
#    keyword = list(
#      c("coca cola", "facebook", "microsoft"),
#      c("alaska air group", "illinois tool works", "jm smucker")
#    ),
#    time = "2010-01-01 2020-12-31"
#  )
#  #> Successfully created new object batch 1 (coca cola ... microsoft, 2010-01-01 2020-12-31).
#  #> Successfully created new object batch 2 (alaska air group ... jm smucker, 2010-01-01 2020-12-31).

## ---- eval = FALSE------------------------------------------------------------
#  # keywords_object and dplyr interaction ----------------------------------------
#  dplyr::filter(keywords_object, keyword == "coca cola")
#  #> # A tibble: 1 x 2
#  #>   batch keyword
#  #>   <int> <chr>
#  #> 1     1 coca cola

## ---- eval = FALSE------------------------------------------------------------
#  # download_object --------------------------------------------------------------
#  download_object(object = new_object, locations = countries)
#  #> Successfully downloaded object data | object: 1 | location: US [1/66]
#  #> ...
#  #> Successfully downloaded object data | object: 2 | location: DO [66/66]

## ---- eval = FALSE------------------------------------------------------------
#  # download_object_global -------------------------------------------------------
#  download_object_global(object = new_object)
#  #> Successfully downloaded object data | object: 1 | location: world [1/1]
#  #> Successfully downloaded object data | object: 2 | location: world [1/1]

## ---- eval = FALSE------------------------------------------------------------
#  # compute_score ----------------------------------------------------------------
#  compute_score(control = new_control[[1]], object = new_object, locations = countries)
#  #> Successfully computed search score | control: 1 | object: 1 | location: US [1/66]
#  #> ...
#  #> Successfully computed search score | control: 1 | object: 2 | location: DO [66/66]

## ---- eval = FALSE------------------------------------------------------------
#  # compute_voi ------------------------------------------------------------------
#  compute_voi(control = new_control[[1]], object = new_object)
#  #> Successfully computed search score | control: 1 | object: 1 | location: world [1/1]
#  #> Successfully computed search score | control: 1 | object: 2 | location: world [1/1]

## ---- eval = FALSE------------------------------------------------------------
#  # compute_doi ------------------------------------------------------------------
#  compute_doi(control = new_control[[1]], object = new_object, locations = "countries")
#  #> Successfully computed DOI | control: 1 | object: 1 [1/2]
#  #> Successfully computed DOI | control: 1 | object: 2 [2/2]

## ---- eval = FALSE------------------------------------------------------------
#  # manual exports ---------------------------------------------------------------
#  library(dplyr)
#  data_score %>%
#    filter(keyword == "coca cola") %>%
#    collect()
#  #> # A tibble: 8,040 x 8
#  #>    location keyword    date score_obs score_sad score_trd batch_c batch_o
#  #>    <chr>    <chr>     <int>     <dbl>     <dbl>     <dbl>   <int>   <int>
#  #>  1 US       coca cola 14610   0.00362   0.00381   0.00548       1      1
#  #>  ...
#  #> 10 US       coca cola 14883   0.00347   0.00365   0.00389       1      1
#  #> # ... with 8,030 more rows

## ---- eval = FALSE------------------------------------------------------------
#  # export_control ---------------------------------------------------------------
#  export_control(control = 1)
#  #> # A tibble: 39,600 x 5
#  #>    location keyword date        hits control
#  #>    <chr>    <chr>   <date>     <dbl>   <int>
#  #>  1 US       gmail   2010-01-01    22       1
#  #>  ...
#  #> 10 US       gmail   2010-10-01    27       1
#  #> # ... with 39,590 more rows
#  
#  # export_score -----------------------------------------------------------------
#  export_score(object = 1, control = 1)
#  #> # A tibble: 23,760 x 8
#  #>    location keyword   date       score_obs score_sad score_trd control object
#  #>    <chr>    <chr>     <date>         <dbl>     <dbl>     <dbl>   <int>  <int>
#  #>  1 US       coca cola 2010-01-01   0.00362   0.00381   0.00548       1     1
#  #>  ...
#  #> 10 US       coca cola 2010-10-01   0.00347   0.00365   0.00389       1     1
#  #> # ... with 23,750 more rows
#  
#  # export_doi and purrr interaction ---------------------------------------------
#  purrr::map_dfr(c("coca cola", "microsoft"), export_doi, control = 1, type = "obs")
#  #> # A tibble: 240 x 9
#  #>    keyword   date       type       gini   hhi entropy control object locations
#  #>    <chr>     <date>     <chr>     <dbl> <dbl>   <dbl>   <int>  <int> <chr>
#  #>  1 coca cola 2010-01-01 score_obs 0.397 0.874  -0.938       1     1 countries
#  #>  ...
#  #> 10 coca cola 2010-10-01 score_obs 0.574 0.968  -0.303       1     1 countries
#  #> # ... with 230 more rows

## ---- eval = FALSE------------------------------------------------------------
#  # export and dplyr interaction -------------------------------------------------
#  library(dplyr)
#  export_doi(object = 1, control = 1, type = "obs") %>%
#    filter(lubridate::year(date) == 2019) %>%
#    group_by(keyword) %>%
#    summarise(gini = mean(gini), .groups = "drop")
#  #> # A tibble: 3 x 2
#  #>   keyword    gini
#  #>   <chr>     <dbl>
#  #> 1 coca cola 0.615
#  #> 2 facebook  0.707
#  #> 3 microsoft 0.682

## ---- eval = FALSE------------------------------------------------------------
#  # plot_score -------------------------------------------------------------------
#  library(dplyr)
#  export_score(keyword = "coca cola", control = 1) %>%
#    filter(lubridate::year(date) == 2019) %>%
#    plot_bar()

## ---- eval = FALSE------------------------------------------------------------
#  # plot_doi_ts and plot_doi_box -------------------------------------------------
#  data <- purrr::map_dfr(1:2, export_doi, keyword = NULL, control = 1, type = "obs")
#  plot_ts(data)
#  plot_box(data)

## ---- eval = FALSE------------------------------------------------------------
#  # plot_voi_doi -----------------------------------------------------------------
#  out_voi <- export_voi(keyword = "facebook", type = "obs")
#  out_doi <- export_doi(keyword = "facebook", object = 1, type = "obs")
#  plot_voi_doi(data_voi = out_voi, data_doi = out_doi)

## ---- eval = FALSE------------------------------------------------------------
#  data <- export_score(keyword = "facebook", locations = countries)
#  out <- get_abnorm_hist(data)
#  na.omit(out) # to drop baseline NA values
#  #> # A tibble: 7,590 x 8
#  #>   keyword  location date       control object score score_abnorm quantile
#  #>   <chr>    <chr>    <date>       <int>  <int> <dbl>        <dbl>    <dbl>
#  #>  1 facebook US       2011-01-01       1      1  1.19      0.0220     0.728
#  #>  ...
#  #> 10 facebook US       2011-10-01       1      1  1.32     -0.0669     0.456
#  #> # ... with 7,580 more rows
#  
#  data <- export_voi(object = 1)
#  out <- get_abnorm_hist(data)
#  na.omit(out) # to drop baseline NA values
#  #> # A tibble: 345 x 7
#  #>    keyword   date       control object     voi voi_abnorm quantile
#  #>    <chr>     <date>       <int>  <int>   <dbl>      <dbl>    <dbl>
#  #>  1 coca cola 2011-01-01       1      1 0.00320  -0.000299    0.316
#  #>  ...
#  #> 10 coca cola 2011-10-01       1      1 0.00274  -0.000458    0.193
#  #> # ... with 335 more rows
#  
#  data <- export_doi(keyword = "microsoft", locations = "us_states")
#  out <- get_abnorm_hist(data)
#  na.omit(out) # to drop baseline NA values
#  #> # A tibble: 345 x 9
#  #>    keyword   date       type      control object locations   doi doi_abnorm quantile
#  #>    <chr>     <date>     <chr>       <int>  <int> <chr>     <dbl>      <dbl>    <dbl>
#  #>  1 microsoft 2011-01-01 score_obs       1      1 us_states 0.919    0.0330     0.991
#  #>  ...
#  #> 10 microsoft 2011-04-01 score_obs       1      1 us_states 0.909    0.0171     0.886
#  #> # ... with 335 more rows

## ---- eval = FALSE------------------------------------------------------------
#  data <- export_score(object = 1, locations = countries)
#  data <- dplyr::filter(data, keyword == "facebook" & lubridate::year(date) >= 2018)
#  # use 2018 as baseline to compute abnormal changes in 2019
#  out <- get_abnorm_hist(data)
#  plot_bar(out)

## ---- eval = FALSE------------------------------------------------------------
#  data <- export_score(keyword = "facebook", locations = "DE")
#  out <- get_abnorm_hist(data)
#  plot_ts(out)
#  
#  data <- export_doi(keyword = "coca cola", locations = "countries")
#  out <- get_abnorm_hist(data)
#  plot_box(out)

## ---- eval = FALSE------------------------------------------------------------
#  # computation seasonally adjusted ----------------------------------------------
#  search_score <- ts(data$hits, frequency = 12)
#  fit <- stl(search_score, s.window = "period")
#  trend <- fit$time.series[, "trend"]
#  # computation trend only -------------------------------------------------------
#  search_score <- ts(data$hits, frequency = 12)
#  fit <- stl(search_score, s.window = "period")
#  seasad <- forecast::seasadj(fit)

## ---- eval = FALSE------------------------------------------------------------
#  # adapt export and plot options ------------------------------------------------
#  data_score <- export_score(keyword)
#  data_voi <- export_voi(keyword)
#  data_doi <- export_doi(keyword, type = "obs")
#  
#  plot_bar(data_score, type = "obs")
#  plot_ts(data_voi, type = "sad")
#  plot_box(data_doi, type = "trd")
#  plot_voi_doi(data_voi, data_doi, type = "obs")
#  
#  get_abnorm_hist(data_voi, type = "obs")

## ---- eval = FALSE------------------------------------------------------------
#  # computation inverted gini coefficient ----------------------------------------
#  dplyr::coalesce(1 - ineq::ineq(search_score, type = "Gini"), 0)
#  # computation inverted herfindahl index ----------------------------------------
#  dplyr::coalesce(1 - sum((search_score / sum(search_score))^2), 0)
#  # computation inverted entropy -------------------------------------------------
#  dplyr::coalesce(-1 * ineq::ineq(search_score, parameter = 1, type = "entropy"), 0)

## ---- eval = FALSE------------------------------------------------------------
#  # adapt export and plot options ------------------------------------------------
#  data_voi <- export_voi(keyword)
#  data_doi <- export_doi(keyword, measure = "gini")
#  
#  plot_ts(data_doi, measure = "gini")
#  plot_box(data_doi, measure = "hhi")
#  plot_voi_doi(data_voi, data_doi, measure = "entropy")
#  
#  get_abnorm_hist(data_doi, measure = "hhi")

## ---- eval = FALSE------------------------------------------------------------
#  # change locations -------------------------------------------------------------
#  download_control(control = 1, locations = us_states)
#  download_object(object = list(1, 2), locations = us_states)
#  download_mapping(control = 1, object = 2, locations = us_states)
#  compute_score(control = 1, object = 2, locations = us_states)
#  compute_doi(control = 1, object = list(1, 2), locations = "us_states")

## ---- eval = FALSE------------------------------------------------------------
#  add_locations(c("AT", "CH", "DE"), type = "dach")
#  #> Successfully created new location set dach (AT, CH, DE).
#  data <- export_score(keyword = "coca cola", locations = dach)
#  dplyr::count(data, location)
#  #> # A tibble: 3 x 2
#  #>   location     n
#  #>   <chr>    <int>
#  #> 1 AT         127
#  #> 2 CH         127
#  #> 3 DE         127

