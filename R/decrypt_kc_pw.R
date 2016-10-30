#' Get a password from OSX Keyring using 'security' cli
#' @param label Keychain password label
#' @return An decrypted password as an invisible string.  Invisible means that
#' the password won't be displayed in the console, but can be assigned to a
#' variable or used inline.
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
decrypt_kc_pw <- function(account) {
  # test OS is Linux
  stopifnot(Sys.info()["sysname"] == "Darwin")
  # execute security command and invisible return result
  invisible(system(paste("security 2>&1 >/dev/null find-generic-password -ga ", account, " | grep '^password' | cut -c 12- | rev | cut -c 2- | rev", sep=""), intern=TRUE))
}

# security 2>&1 >/dev/null find-generic-password -ga dwstats_dwpd | grep '^password' | cut -c 12- | rev | cut -c 2- | rev
