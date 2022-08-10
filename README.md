
<!-- README.md is generated from README.Rmd. Please edit that file -->

# UKpopData

<!-- badges: start -->
<!-- badges: end -->

## About

Trying to gather population data by age and year historical and
projections to use in regression models for driving test demand
forecasts.

## Installation

Not yet on guthub, ask Mark for the package file

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(UKpopData)
get_pop_data()
#> # A tibble: 27 x 319
#>    Year  Total_Age_0 Total_Age_1 Total_Age_2 Total_Age_3 Total_Age_4 Total_Age_5
#>    <chr>       <dbl>       <dbl>       <dbl>       <dbl>       <dbl>       <dbl>
#>  1 2001       662662      679455      698903      710986      730156      724436
#>  2 2002       661786      664800      682505      702372      714737      734046
#>  3 2003       679910      662639      667850      685822      706437      718816
#>  4 2004       704450      679406      663651      670805      689289      710619
#>  5 2005       716331      704755      680794      665589      674460      691326
#>  6 2006       734035      716092      704383      681323      666792      676448
#>  7 2007       757429      737641      717749      705686      683009      668737
#>  8 2008       788225      758643      740782      718402      705931      683652
#>  9 2009       782726      787962      759942      743661      718630      706675
#> 10 2010       791801      781631      788659      761633      746833      719662
#> # ... with 17 more rows, and 312 more variables: Total_Age_6 <dbl>,
#> #   Total_Age_7 <dbl>, Total_Age_8 <dbl>, Total_Age_9 <dbl>,
#> #   Total_Age_10 <dbl>, Total_Age_11 <dbl>, Total_Age_12 <dbl>,
#> #   Total_Age_13 <dbl>, Total_Age_14 <dbl>, Total_Age_15 <dbl>,
#> #   Total_Age_16 <dbl>, Total_Age_17 <dbl>, Total_Age_18 <dbl>,
#> #   Total_Age_19 <dbl>, Total_Age_20 <dbl>, Total_Age_21 <dbl>,
#> #   Total_Age_22 <dbl>, Total_Age_23 <dbl>, Total_Age_24 <dbl>, ...
```

## Obtaining Historical data

It appears to be a static spreadsheet which changes name every time is
it updated

Current release date: 25 June 2021

Next Release due: September 2022

-   Start website: [www.ons.gov.uk](https://www.ons.gov.uk)
-   Main menu: People, population and community Dropdown option:
    Population and migration
-   In this section option: Population estimates Scroll down to:
    Datasets related to population estimates
-   Select: Estimates of the population for the UK, England and Wales,
    Scotland and Northern Ireland
-   Expand section: Mid-2001 to mid-2020 detailed time series edition of
    this dataset
-   Supporting files you may find useful: UK population estimates, 1838
    to 2020 (XLSX, 2.0 MB)

Direct link to current file: [UK population estimates, 1838 to 2020
(XLSX, 2.0
MB)](https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland/mid2001tomid2020detailedtimeseries/ukpopulationestimates18382020.xlsx)

## Obtaining Projected Data

From a tool from the ONS to download customised data

-   Start website: [www.nomisweb.co.uk](https://www.nomisweb.co.uk)
-   Data Downloads section: Query Data
-   Select Datasets by source: Population Estimates/Projections
-   Opened folder: National Population projections by single age of year

Make the following selections:

-   Geography: Great Britain
-   Ages: un-check all “Labour Market categories” and check only 3rd box
    in quick select section for Individual ages and 5 year age bands
    section, thereby selecting only ages
-   Select Years: Future years on from Historic data (2021 upwards to
    2027, in this case )
-   Select gender: Total, Males and Females
-   Format selection: Microsoft Excel (.xlsx)
-   Layout: projected year
-   Other options: One table per worksheet checked

Wait, then download data

Due to the nature of the web-application there is no static link to the
current file

## Historical Data structure

The downloaded file has many tabs

The required table is called “Population estimates for UK, by sex and
single year of age, mid-1971 to mid-2020” and is currently Table 3 (also
tab “Table 3”)

There are 3 tables, arranged vertically in this order: All Persons, Male
then Female. All 3 tables have column per year, starting with the most
recent, and one row per age, starting with 0 years, ages 90+ are
aggregated into one row.

## Projected Data Structure

The downloaded file will have 3 tabs, each tab has one table.

The tabs are named appropriately: Total, Male and Female

All 3 tables have one column per year, starting with the oldest, and one
row per age, starting with 0 up to the maximum age, without any
aggregation for 90+
