#' Get Uk population data
#' 
#' @description UK population data for Males, Females and Total
#' 
#' One Year per row
#' One column for each gender / age combinations
#' Eg  Total_Age_17, Male_Age_21, Female_Age_30
#'
#' @return a tibble containing UK population data
#' @export
get_pop_data <- function() {
    # set up local variables to avoid check() warnings
    Age <- NULL
    table_number <- NULL
    table_name <- NULL
    Year <- NULL
    
    # get absolute file locations for the source files
    hist_filename <- system.file("extdata", "ukpopulationestimates18382020.xlsx", package = "UKpopData")
    proj_filename <- system.file("extdata", "nomis_2022_08_04_115225.xlsx", package = "UKpopData")
    
    # load data
    historic_pop_raw <- 
        readxl::read_xlsx(hist_filename,
                  sheet = "Table 3",
                  skip = 4,
                  col_names = TRUE)
    
    # have to read tabs individually
    proj_pop_total_raw <- 
        readxl::read_xlsx(proj_filename,
                  sheet = "Total",
                  skip = 6,
                  col_names = TRUE)
    
    proj_pop_male_raw <- 
        readxl::read_xlsx(proj_filename,
                  sheet = "Male",
                  skip = 6,
                  col_names = TRUE)
    
    proj_pop_female_raw <- 
        readxl::read_xlsx(proj_filename,
                  sheet = "Female",
                  skip = 6,
                  col_names = TRUE)
    
    # clean the historic data
    historic_pop_clean <- 
        historic_pop_raw %>%
        # drop years columns that are not needed
        # keep 20 years (21 cols)
        dplyr::select(1:21) %>%
        tidyr::drop_na() %>%
        # remove annual total
        dplyr::filter(!Age == "All Ages") %>%
        # add column to identify each table using repeated Age (1 for each table)
        dplyr::group_by(Age) %>%
        dplyr::mutate(table_number = dplyr::row_number(Age)) %>%
        dplyr::relocate(table_number) %>%
        dplyr::mutate(
            table_name = dplyr::case_when(
                table_number == 1 ~ "Total",
                table_number == 2 ~ "Male",
                table_number == 3 ~ "Female",
                TRUE ~ "Unknown"
            )
        ) %>%
        dplyr::relocate(table_name) %>%
        dplyr::select(-table_number) %>%
        dplyr::ungroup() %>%
        transpose_pop()
    
    # clean the projected data
    proj_pop_clean <- 
        dplyr::bind_rows(
            proj_pop_total_raw %>%
                dplyr::mutate(table_name = "Total"),
            proj_pop_male_raw %>%
                dplyr::mutate(table_name = "Male"),
            proj_pop_female_raw %>%
                dplyr::mutate(table_name = "Female")
        ) %>%
        # change Age to be same as historic, have underscore not space
        dplyr::mutate(
            Age = stringr::str_replace(Age, " ", "_"),
            Age = stringr::str_remove(Age, "d")
        ) %>%
        transpose_pop()
    
    # join and return the data
    dplyr::bind_rows(
        historic_pop_clean,
        proj_pop_clean
    ) %>%
        dplyr::arrange(Year)
     
}



#' Transpose population table from Age in Rows and Year in Columns
#' to Year in rows and Age in columns
#'
#' @param tbl tibble: must have Age and table_name columns
#'
#' @return tibble: the transposed table
#' @export
#'
transpose_pop <- function(tbl) {
    # set up local variables to avoid check() warnings
    Age <- NULL
    table_name <- NULL
    Pop <- NULL
    Year <- NULL
    
    # check we have table_name and Age columns and fail if not
    #
    #
    
    tbl %>%
        tidyr::pivot_longer(-c(table_name, Age),
                     names_to = "Year",
                     values_to = "Pop") %>%
        # add "Age_" to Age column if needed
        # remove "Mid-" from year
        dplyr::mutate(
            Age = dplyr::if_else(stringr::str_detect(Age, "Age_"), Age, paste0("Age_", Age)),
            Year = stringr::str_remove(Year, "Mid-")
        ) %>%
        tidyr::pivot_wider(Year,
                    names_from = c(table_name, Age),
                    values_from = Pop,
                    names_glue = "{table_name}_{Age}")
}