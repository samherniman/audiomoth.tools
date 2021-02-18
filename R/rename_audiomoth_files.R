#' Rename audiomoth files to be compatible with Arbimon
#'
#' @description This function removes the 'T' from the end of audiomoth filenames allowing them to be uploaded to Arbimon
#' @param dir_path a path to the directory of audiomoth files
#'
#' @return
#' @export TRUE
#'
#'
#' @examples
rename_audiomoth_files <- function(dir_path) {
  files_vec <- list.files(dir_path, full.names = TRUE)
  sapply(files_vec,FUN=function(eachPath){
    file.rename(from=eachPath,to=stringr::str_remove(eachPath, "T"))
    })
}
