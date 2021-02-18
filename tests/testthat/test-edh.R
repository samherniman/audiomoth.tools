
test_string <- "Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160."
test_that("edh works", {
  expect_equal(ehd("Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160.")[1], "Recorded at 12:21:00 10/02/2021")
  expect_equal(ehd("Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160.")[3], "AudioMoth 24E144085F256717")
  expect_equal(ehd("Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160.")[4], "at medium gain")
  expect_equal(ehd("Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160.")[5], "3.9V")
  expect_equal(ehd("Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160.")[6], "-2.6C")
})
