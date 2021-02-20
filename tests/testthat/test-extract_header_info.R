header_tb <- extract_header_info(system.file("extdata", package = "audiomoth.tools"))

test_that("extracting headers works", {
  expect_equal(length(header_tb), 6)
  expect_equal(nrow(header_tb), 3)
  expect_equal(header_tb$gain_setting[1], "medium")
  expect_equal(class(header_tb$recorded_date_time)[1], "POSIXct")
})
