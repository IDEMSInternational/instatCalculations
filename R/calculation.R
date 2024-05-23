calculation <- R6::R6Class("calculation",
                           public = list(
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
                           # ,
                           # Removed because filter_conditions can be public
                           # private = list(
                           #   .filter_conditions = list()
                           # )
                           # ,
                           # active = list(
                           #   filter_conditions = function(new_filter_conditions) {
                           #     if(missing(new_filter_conditions)) return(private$.filter_conditions)
                           #     else private$.filter_conditions <- new_filter_conditions
                           #   }
                           # )
)
