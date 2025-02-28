# Test suite for Calculation Class
test_that("calculation class initialises correctly", {
  calc <- calculation$new(
    function_name = "sum",
    parameters = list(a = 1, b = 2),
    is_recalculable = TRUE,
    sub_calculations = list(),
    type = "arithmetic",
    filter_conditions = list("a > 0"),
    filters = list("filter1"),
    name = "calc1"
  )
  
  expect_equal(calc$function_name, "sum")
  expect_equal(calc$parameters, list(a = 1, b = 2))
  expect_true(calc$is_recalculable)
  expect_equal(calc$sub_calculations, list())
  expect_equal(calc$type, "arithmetic")
  expect_equal(calc$filter_conditions, list("a > 0"))
  expect_equal(calc$filters, list("filter1"))
  expect_equal(calc$name, "calc1")
})

test_that("data_clone method creates an identical copy", {
  calc <- calculation$new(
    function_name = "multiply",
    parameters = list(x = 3, y = 4),
    calculated_from = c("varA", "varB"),
    is_recalculable = FALSE,
    sub_calculations = list(),
    type = "multiplication",
    filter_conditions = list("x > 0"),
    filters = list("filterX"),
    name = "calc2"
  )
  
  cloned_calc <- calc$data_clone()
  
  expect_equal(cloned_calc$function_name, calc$function_name)
  expect_equal(cloned_calc$parameters, calc$parameters)
  expect_equal(cloned_calc$calculated_from, calc$calculated_from)
  expect_equal(cloned_calc$is_recalculable, calc$is_recalculable)
  expect_equal(cloned_calc$sub_calculations, calc$sub_calculations)
  expect_equal(cloned_calc$type, calc$type)
  expect_equal(cloned_calc$filter_conditions, calc$filter_conditions)
  expect_equal(cloned_calc$filters, calc$filters)
  expect_equal(cloned_calc$name, calc$name)
  # Ensure it's a different object
  expect_false(identical(cloned_calc, calc))
})
