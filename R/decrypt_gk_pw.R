#' Get a password from Gnome Keyring using secret-tool
#' @param key_value_pairs A string of key value pairs as expected by secret-tool
#' @return An decrypted password as an invisible string.  Invisible means that
#' the password won't be displayed in the console, but can be assigned to a
#' variable or used inline.
#' @details
#' Requires the Gnome Keyring and secret-tool to be installed.
#' @examples
#' \dontrun{
#' # First encrypt a password using secret-tool as follows:
#' # secret-tool store --label=mylabel db mydb user user1
#' # now return the password above to the R environment
#' x <- decrypt_gk_pw("db mydb user user1")
#'
#' # function is best used in a connection string command:
#' ch <- odbcConnect("some dsn", uid = "user1", pwd = decrypt_gk_pw("db mydb user user1"))
#' }
#' @export
decrypt_gk_pw <- function(key_value_pairs) {
  # test OS is Linux
  stopifnot(Sys.info()["sysname"] == "Linux")
  # execute secret-tool command and invisible return result
  invisible(system(paste("secret-tool lookup ", key_value_pairs, sep=""), intern=TRUE))
  }

