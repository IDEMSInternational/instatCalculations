#' Check and update filter object parameters
#'
#' @param filter_obj A filter object to check and update.
#' @return The updated filter object.
#' @export
check_filter <- function(filter_obj) {
  if (is.null(filter_obj$parameters[["and_or"]])) filter_obj$parameters[["and_or"]] <- "&"
  if (is.null(filter_obj$parameters[["outer_not"]])) filter_obj$parameters[["outer_not"]] <- FALSE
  if (is.null(filter_obj$parameters[["inner_not"]])) filter_obj$parameters[["inner_not"]] <- FALSE
  return(filter_obj)
}