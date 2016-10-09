#' Get a password from Gnome Keyring using secret-tool
#'
#' @param key_value_pairs A list of key value pairs as expected by secret-tool (see example)
#' @return A decrypted password as a string.
#' @examples
#' add(1, 1)
#' @export
decryptGnomeKeyring <- function(key_value_pairs) {
  return(system(paste("secret-tool lookup ", key_value_pairs, sep="")))
}
