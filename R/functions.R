#' Transpose population table from Age in Rows and Year in Columns
#' to Year in rows and Age in columns
#'
#' @param tbl tibble: must have Age and table_name columns
#'
#' @return tibble: the transposed table
#' @export
#'
transpose_pop <- function(tbl) {
    # check we have table_name and Age columns and fail if not
    #
    #
    
    tbl %>%
        pivot_longer(-c(table_name, Age),
                     names_to = "Year",
                     values_to = "Pop") %>%
        # add "Age_" to Age column if needed
        # remove "Mid-" from year
        mutate(
            Age = if_else(str_detect(Age, "Age_"), Age, paste0("Age_", Age)),
            Year = str_remove(Year, "Mid-")
        ) %>%
        pivot_wider(Year,
                    names_from = c(table_name, Age),
                    values_from = Pop,
                    names_glue = "{table_name}_{Age}")
}