#' Calculation Class
#'
#' @description
#' Represents a calculation with associated parameters, filters, and sub-calculations.
#'
#' @field function_name Character. The name of the function.
#' @field parameters List. The parameters for the calculation.
#' @field calculated_from Character vector. Sources from which the calculation is derived.
#' @field is_recalculable Logical. Indicates if the calculation is recalculable.
#' @field sub_calculations List. A list of sub-calculations.
#' @field type Character. The type of calculation.
#' @field filter_conditions List. The conditions used to filter data.
#' @field filters List. The filters applied to the data.
#' @field name Character. The name of the calculation instance.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{add_sub_calculation(sub_calculation, name)}}{Add a sub-calculation.}
#'   \item{\code{data_clone(...)}}{Clone the data.}
#' }
#' @export
calculation <- R6::R6Class("calculation",
                           public = list(
                             
                             #' @description Initialize the calculation class.
                             #' 
                             #' @param function_name Character. The name of the function. Default is an empty string.
                             #' @param parameters List. The parameters for the calculation. Default is an empty list.
                             #' @param calculated_from Character vector. Sources from which the calculation is derived. Default is an empty vector.
                             #' @param is_recalculable Logical. Indicates if the calculation is recalculable. Default is `TRUE`.
                             #' @param sub_calculations List. A list of sub-calculations. Default is an empty list.
                             #' @param type Character. The type of calculation. Default is an empty string.
                             #' @param filter_conditions List. The conditions used to filter data. Default is an empty list.
                             #' @param filters List. The filters applied to the data. Default is an empty list.
                             #' @param name Character. The name of the calculation instance. Default is an empty string.
                             initialize = function(function_name = "", parameters = list(), 
                                                   calculated_from = c(), is_recalculable = TRUE,
                                                   sub_calculations = list(), type = "", filter_conditions = list(),
                                                   filters = list(), name = "") {
                               self$function_name <- function_name
                               self$parameters <- parameters
                               self$calculated_from <- calculated_from
                               self$is_recalculable <- is_recalculable
                               self$sub_calculations <- sub_calculations
                               self$type <- type
                               self$name <- name
                               self$filter_conditions <- filter_conditions
                               self$filters <- filters
                             },
                             
                             function_name = "",
                             parameters = list(), 
                             calculated_from = c(),
                             is_recalculable = TRUE,
                             sub_calculations = list(),
                             type = "",
                             filter_conditions = list(),
                             filters = list(),
                             name = "",
                             
                             #' @description Add a sub-calculation.
                             #' 
                             #' @param sub_calculation An object representing the sub-calculation to add.
                             #' @param name Character. The name of the sub-calculation.
                             add_sub_calculation = function(sub_calculation, name) {
                               self$sub_calculations[[name]] <- sub_calculation
                             },
                             
                             #' @description Clone the data.
                             #' @param ... Additional methods to add to the function.
                             #' @return A new instance of the calculation class with the same data.
                             data_clone = function(...) {
                               ret <- calculation$new(function_name = self$function_name, parameters = self$parameters, 
                                                      calculated_from = self$calculated_from, is_recalculable = self$is_recalculable,
                                                      sub_calculations = self$sub_calculations, type = self$type, 
                                                      filter_conditions = self$filter_conditions, filters = self$filters,
                                                      name = self$name)
                               return(ret)
                             }
                           )
)
