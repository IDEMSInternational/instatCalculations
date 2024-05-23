#' Convert calculation list to a specific format
#'
#' @param x A list of calculations.
#' @return A formatted list of calculations.
#' @export
calc_from_convert <- function(x) {
  calc_list <- list()
  for (i in seq_along(x)) {
    for (j in seq_along(x[[i]])) {
      calc_list[[length(calc_list) + 1]] <- x[[i]][j]
      names(calc_list)[length(calc_list)] <- names(x)[i]
    }
  }
  return(calc_list)
}