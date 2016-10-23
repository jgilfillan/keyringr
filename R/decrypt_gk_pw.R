#' Get a password from Gnome Keyring using secret-tool
#'
#' @param key_value_pairs A string of key value pairs as expected by secret-tool (see example)
#' @return A decrypted password as a string.
#' @examples
#' \dontrun{
#' # returns the password for the key-value pair key: MYSCHEMA_MYDB
#' decrypt_gk_pw("key MYSCHEMA_MYDB")
#' }
#' @export
decrypt_gk_pw <- function(key_value_pairs) {
  stopifnot(Sys.info()["sysname"] == "Linux")
  return(invisible(system(paste("secret-tool lookup ", key_value_pairs, sep=""))))
}

