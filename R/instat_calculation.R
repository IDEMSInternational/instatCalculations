#' instat_calculation Class
#'
#' A class to store calculations.
#'
#' @field function_exp A string passed directly to one of dplyr functions.
#' @field type The type of calculation.
#' @field name The name of the calculation instance.
#' @field result_name The name for the output produced by the calculation.
#' @field result_data_frame The data frame that the output should go to.
#' @field manipulations A list of calculations to be performed before sub_calculations and the main calculation.
#' @field sub_calculations A list of calculations to be performed after manipulations.
#' @field calculated_from A list of columns the calculation depends on.
#' @field save An integer indicating whether the calculation and result should be saved.
#' @field before A boolean indicating if the calculation should be performed before others.
#' @field adjacent_column The name of the adjacent column.
#' @export
instat_calculation <- R6::R6Class(
  "instat_calculation",
  public = list(
    # Initialise the instat_calculation class
    #
    #' @param function_exp A string passed directly to one of dplyr functions.
    #' @param type The type of calculation.
    #' @param name The name of the calculation instance.
    #' @param result_name The name for the output produced by the calculation.
    #' @param result_data_frame The data frame that the output should go to.
    #' @param manipulations A list of calculations to be performed before sub_calculations and the main calculation.
    #' @param sub_calculations A list of calculations to be performed after manipulations.
    #' @param calculated_from A list of columns the calculation depends on.
    #' @param save An integer indicating whether the calculation and result should be saved.
    #' @param before A boolean indicating if the calculation should be performed before others.
    #' @param adjacent_column The name of the adjacent column.
    initialize = function(function_exp = "", type = "", name = "", result_name = "", result_data_frame = "", manipulations = list(),
                          sub_calculations = list(), calculated_from = list(), save = 0, before = FALSE, adjacent_column = "") {
      if((type == "calculation" || type == "summary") && missing(result_name)) stop("result_name must be provided for calculation and summary types")
      if(type == "combination" && save > 0) {
        warning("combination types do not have a main calculation which can be saved. save_output will be stored as FALSE")
        save <- 0
      }
      self$function_exp <- function_exp
      self$type <- type
      self$name <- name
      self$result_name <- result_name
      self$result_data_frame <- result_data_frame
      self$manipulations <- manipulations
      self$sub_calculations <- sub_calculations
      self$calculated_from <- calculated_from
      self$save <- save
      self$before <- before
      self$adjacent_column <- adjacent_column
    },
    name = "",
    result_name = "",
    result_data_frame = "",
    type = "",
    manipulations = list(),
    sub_calculations = list(),
    function_exp = "",
    calculated_from = list(),
    save = 0,
    before = FALSE,
    adjacent_column = ""
  )
)

#' Clone Data
#'
#' @return A new instance of the instat_calculation class with the same data.
#' @export
instat_calculation$set("public", "data_clone", function(...) {
  ret <- instat_calculation$new(function_exp = self$function_exp, type = self$type,
                                name = self$name, result_name = self$result_name, 
                                manipulations = lapply(self$manipulations, function(x) x$data_clone()), 
                                sub_calculations = lapply(self$sub_calculations, function(x) x$data_clone()),
                                calculated_from = self$calculated_from, save = self$save)
  return(ret)
})

#' Get Dependencies
#'
#' @param depens A vector of dependencies.
#' @return A vector of dependencies.
#' @export
instat_calculation$set("public", "get_dependencies", function(depens = c()) {
  for(manip in self$manipulations) {
    for(i in seq_along(manip$calculated_from)) {
      ind <- which(depens == manip$calculated_from[[i]])
      if(length(ind) == 0 || names(depens)[ind] != names(manip$calculated_from)[i]) {
        depens <- c(depens, manip$calculated_from[i])
      }
    }
  }
  for(sub_calc in self$sub_calculations) {
    depens <- sub_calc$get_dependencies(depens)
  }
  for(j in seq_along(self$calculated_from)) {
    ind <- which(depens == self$calculated_from[[j]])
    if(length(ind) == 0 || names(depens)[ind] != names(self$calculated_from)[j]) {
      depens <- c(depens, self$calculated_from[j])
    }
  }
  return(depens)
})
