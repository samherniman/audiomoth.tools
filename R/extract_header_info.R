#' Extract information from audiomoth wav file headers
#'
#' @param dir_path path to directory that holds audiomoth files
#' @param recursive FALSE only searches the specified folder. TRUE searches folders recursively
#'
#' @return dataframe with recording time, settings, battery and temperature
#' @export
#'
#' @examples
#' extract_header_info(system.file("extdata", package = "audiomoth.tools"))
extract_header_info <- function(dir_path, recursive = FALSE) {

  ts_vec <- sapply(
    list.files(
        dir_path,
        pattern = ".WAV$",
        recursive = recursive,
        full.names = TRUE),
    FUN=function(eachPath){
        ehd(
          readLines(eachPath, skipNul = TRUE)[1])

  })

  ts_vec <- t(ts_vec)
  colnames(ts_vec) <- c("date", "tz", "sn", "gain", "volt", "temp")

  ts_vec <- tibble::as_tibble(ts_vec, .name_repair = "check_unique")

  dplyr::transmute(ts_vec,
      recorded_date_time = lubridate::parse_date_time(date, "HMS dmy"),
      timezone = stringr::str_sub(tz, start = 2L, end = -2L),
      sensor_name_serial_number = sn,
      gain_setting = stringr::str_sub(gain, start = 4L, end = -6L),
      battery_voltage = as.numeric(stringr::str_sub(volt, end = -2L)),
      temperature_celcius = as.numeric(stringr::str_sub(temp, end = -2L))
    )
}


