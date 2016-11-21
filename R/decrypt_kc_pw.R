#' Get a generic password from OSX Keychain using the 'security' cli
#' @param label Keychain password label
#' @param type Leychain password type.  Either "generic" or "internet".
#' @return Returns a decrypted password as an invisible string.  Invisible means that
#' the password won't be displayed in the console, but can be assigned to a
#' variable or used inline.
#' @details
#' Passwords must be saved in Keychain prior to using the function.
#'
#' OSX may require the user to grant access to "security" the first time the function
#' is run for each password.  It is important to select "Always allow", which will
#' prevent similar dialogs in the future.
#' @examples
#' \dontrun{
#' # First store a password in Keychain
#' # now return the password above to the R environment
#' x <- decrypt_kc_pw("label")
#'
#' # function is best used in a connection string command:
#' ch <- odbcConnect("some dsn", uid = "user1", pwd = decrypt_kc_pw("mydb_myuser"))
#' }
#' @export
decrypt_kc_pw <- function(label, type = "generic") {
  # test OS is Linux
  stopifnot(Sys.info()["sysname"] == "Darwin")
  stopifnot((type %in% c("generic","internet")))
  # execute security command and invisible return result
  invisible(system(paste("security 2>&1 >/dev/null find-", type,"-password -gl ", label, " | grep '^password' | cut -c 12- | rev | cut -c 2- | rev", sep=""), intern=TRUE))
}
