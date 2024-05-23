#' Find data frame from calculation list
#'
#' @param x A list of calculations.
#' @param column The column name to search for.
#' @return The name of the data frame associated with the column.
#' @export
find_df_from_calc_from <- function(x, column) {
  for (i in seq_along(x)) {
    if (column %in% x[[i]]) return(names(x)[i])
  }
  return("")
}
