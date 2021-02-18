#' Extract strings from a single header
#'
#' @param header_vec wave header string
#'
#' @return vector holding header data (recording time, time zone, audiomoth serial number, gain, voltage, temperature)
#' @export
#'
#' @examples
#' test_string <- "Recorded at 12:21:00 10/02/2021 (UTC) by AudioMoth 24E144085F256717 at medium gain setting while battery state was 3.9V and temperature was -2.6C. Amplitude threshold was 160."
#' ehd(test_string)
ehd <- function(header_vec) {
  c(stringr::str_extract(
    header_vec,
    "Recorded at \\d\\d:\\d\\d:\\d\\d \\d\\d/\\d\\d/\\d\\d\\d\\d"
  ), stringr::str_extract(
    header_vec,
    "\\(UTC([:punct:]\\d+)?:?(\\d\\d)?\\)"
  ), stringr::str_extract(
    header_vec,
    "AudioMoth \\S+"
  ), stringr::str_extract(
    header_vec,
    "at [:lower:]+ gain"
  ),
  stringr::str_extract(
    header_vec,
    "\\d\\.\\dV"
  ), stringr::str_extract(
    header_vec,
    "[:punct:]?\\d+\\.\\dC"
  )
  )
}
