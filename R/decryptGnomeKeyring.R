#' Get a password from Gnome Keyring using secret-tool
#'
#' @param key_value_pairs A string of key value pairs as expected by secret-tool (see example)
#' @return A decrypted password as a string.
#' @examples
#' \dontrun{
#' # returns the password for the key-value pair key: MYSCHEMA_MYDB
#' decryptGnomeKeyring("key MYSCHEMA_MYDB")
#' }
#' @export
decryptGnomeKeyring <- function(key_value_pairs) {
  return(system(paste("secret-tool lookup ", key_value_pairs, sep="")))
}

