# Test suite for instat_calculation Class
test_that("instat_calculation class initializes correctly", {
  instat_calc <- instat_calculation$new(
    function_exp = "sum",
    type = "summary",
    name = "instat1",
    result_name = "result1",
    result_data_frame = "df1",
    manipulations = list(),
    sub_calculations = list(),
    calculated_from = list("varX"),
    save = 1,
    before = TRUE,
    adjacent_column = "colA",
    param_list = list(drop = TRUE)
  )
  
  expect_equal(instat_calc$function_exp, "sum")
  expect_equal(instat_calc$type, "summary")
  expect_equal(instat_calc$name, "instat1")
  expect_equal(instat_calc$result_name, "result1")
  expect_equal(instat_calc$result_data_frame, "df1")
  expect_equal(instat_calc$manipulations, list())
  expect_equal(instat_calc$sub_calculations, list())
  expect_equal(instat_calc$calculated_from, list("varX"))
  expect_equal(instat_calc$save, 1)
  expect_true(instat_calc$before)
  expect_equal(instat_calc$adjacent_column, "colA")
  expect_equal(instat_calc$param_list, list(drop = TRUE))
})


test_that("data_clone method creates an identical copy for instat_calculation", {
  instat_calc <- instat_calculation$new(
    function_exp = "sum",
    type = "summary",
    name = "instat1",
    result_name = "result1",
    manipulations = list(),
    sub_calculations = list(),
    calculated_from = list("varX"),
    save = 1,
    param_list = list(drop = TRUE)
  )
  
  cloned_instat_calc <- instat_calc$data_clone()
  
  expect_equal(cloned_instat_calc$function_exp, instat_calc$function_exp)
  expect_equal(cloned_instat_calc$type, instat_calc$type)
  expect_equal(cloned_instat_calc$name, instat_calc$name)
  expect_equal(cloned_instat_calc$result_name, instat_calc$result_name)
  expect_equal(cloned_instat_calc$manipulations, instat_calc$manipulations)
  expect_equal(cloned_instat_calc$sub_calculations, instat_calc$sub_calculations)
  expect_equal(cloned_instat_calc$calculated_from, instat_calc$calculated_from)
  expect_equal(cloned_instat_calc$save, instat_calc$save)
  expect_equal(cloned_instat_calc$param_list, instat_calc$param_list)
  expect_false(identical(cloned_instat_calc, instat_calc))  # Ensure it's a different object
})


test_that("get_dependencies method returns correct dependencies", {
  instat_calc <- instat_calculation$new(
    calculated_from = list("varA", "varB")
  )
  
  dependencies <- instat_calc$get_dependencies()
  
  expect_true("varA" %in% dependencies)
  expect_true("varB" %in% dependencies)
})
