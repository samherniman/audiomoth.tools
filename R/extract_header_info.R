#' Extract information from audiomoth wav file headers
#'
#' @param dir_path path to directory that holds audiomoth files
#'
#' @return dataframe with recording time, settings, battery and temperature
#' @export
#'
#' @examples
#' extract_header_info(system.file("extdata", package = "audiomoth.tools"))
extract_header_info <- function(dir_path) {

  ts_vec <- sapply(
    list.files(
        dir_path,
        pattern = ".WAV$",
        full.names = TRUE),
    FUN=function(eachPath){
        ehd(
          readLines(eachPath, skipNul = TRUE)[1])

  })

  ts_vec <- t(ts_vec)
  colnames(ts_vec) <- c("date", "tz", "sn", "gain", "volt", "temp")

  tibble::as_tibble(ts_vec, .name_repair = "check_unique") %>%
    dplyr::transmute(
      recorded_date_time = lubridate::parse_date_time(date, "HMS dmy"),
      timezone = stringr::str_sub(tz, start = 2L, end = -2L),
      sensor_name_serial_number = sn,
      gain_setting = stringr::str_sub(gain, start = 4L, end = -6L),
      battery_voltage = stringr::str_sub(volt, end = -2L) %>% as.numeric(),
      tempeature_celcius = stringr::str_sub(temp, end = -2L) %>% as.numeric()
    )
}


