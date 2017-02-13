#' Get a account name from macOS Keychain using the 'security' cli
#' @param label Keychain password label
#' @param type Leychain password type.  Either "generic" or "internet".
#' @return Returns the account value attached to the label.
#'
#' macOS may require the user to grant access to "security" the first time the function
#' is run for each stored credential.  It is important to select "Always allow", which will
#' prevent similar dialogs in the future.
#' @examples
#' \dontrun{
#' # First store a set of credentials in Keychain
#' # now return the account name to the R environment
#' x <- get_kc_account("label")
#' }
#'
#' @export
get_kc_account <- function(label, type = "generic") {
  # test OS is macOS
  stopifnot(Sys.info()["sysname"] == "Darwin")
  stopifnot((type %in% c("generic","internet")))
  # execute security command and invisible return result
  return(stringr::str_sub(system2("security", args = c(paste("find-", type, "-password", sep = ""), "-gl", label), stderr = FALSE, stdout = TRUE)[7], 19, -2))
}
