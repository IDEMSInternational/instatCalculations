#' calculation Class
#'
#' An example R6 class for performing calculations.
#'
#' @field function_name The name of the function.
#' @field parameters The parameters for the calculation.
#' @field calculated_from A vector of sources from which the calculation is derived.
#' @field is_recalculable A boolean indicating if the calculation is recalculable.
#' @field sub_calculations A list of sub-calculations.
#' @field type The type of calculation.
#' @field filter_conditions The conditions used to filter data.
#' @field filters The filters applied to the data.
#' @field name The name of the calculation instance.
#' @export
calculation <- R6::R6Class(
  "calculation",
  public = list(
    # Initialise the calculation class
    #
    #' @param function_name The name of the function. Default is an empty string.
    #' @param parameters A list of parameters for the calculation. Default is an empty list.
    #' @param calculated_from A vector of sources from which the calculation is derived. Default is an empty vector.
    #' @param is_recalculable A boolean indicating if the calculation is recalculable. Default is TRUE.
    #' @param sub_calculations A list of sub-calculations. Default is an empty list.
    #' @param type The type of calculation. Default is an empty string.
    #' @param filter_conditions The conditions used to filter data. Default is an empty list.
    #' @param filters The filters applied to the data. Default is an empty list.
    #' @param name The name of the calculation instance. Default is an empty string.
    initialize = function(function_name = "", parameters = list(), 
                          calculated_from = c(), is_recalculable = TRUE,
                          sub_calculations = list(), type = "", filter_conditions = list(),
                          filters = list(), name = "") {
      self$function_name = function_name
      self$parameters = parameters
      self$calculated_from = c()
      self$is_recalculable = is_recalculable
      self$sub_calculations = sub_calculations
      self$type = type
      self$name = name
      self$filter_conditions = filter_conditions
      self$filters = filters
    },
    function_name = "",
    parameters = list(), 
    calculated_from = c(),
    is_recalculable = TRUE,
    sub_calculations = list(),
    filter_conditions = list(),
    filters = list(),
    name = "",
    type = ""
  )
)

#' Add a Sub Calculation
#'
#' @param sub_calculation The sub calculation to add.
#' @param name The name of the sub calculation.
#' @export
calculation$set("public", "add_sub_calculation", function(sub_calculation, name) {
  self$sub_calculations[[name]] <- sub_calculation
})

#' Clone Data
#'
#' @return A new instance of the calculation class with the same data.
#' @export
calculation$set("public", "data_clone", function() {
  ret <- calculation$new(function_name = self$function_name, parameters = self$parameters, 
                         calculated_from = self$calculated_from, is_recalculable = self$is_recalculable,
                         sub_calculations = self$sub_calculations, type = self$type, 
                         filter_conditions = self$filter_conditions, filters = self$filters,
                         name = self$name)
  return(ret)
})