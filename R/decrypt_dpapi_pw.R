#' Decrypt passwords encrypted with  the Microsoft Data Protection API
#' @param file File that holds a password encrypted using DPAPI
#' @return An decrypted password as an invisible string.  Invisible means that
#' the password won't be displayed in the console, but can be assigned to a
#' variable or used inline.
#' @details
#' Requires Powershell to be installed and execution policy set to RemoteSigned.
#' This can be achieved by running
#' \code{
#' Set-ExecutionPolicy RemoteSigned
#' }
#' from Powershell.
#' @examples
#' \dontrun{
#' # First run the command below from Powershell:
#' # Read-Host "PW?" -AsSecureString |  ConvertFrom-SecureString | Out-File "C:\Temp\Password.txt"
#' # Now execute the following R commands to decrypt the password and save it in
#' # variable "x".  Note that if run without assignment, the password will not
#' # be displayed in the console.  Passwords must be saved to a variable or used
#' # inline within a connection string.
#' library("keyringr")
#' x <- decrypt_dpapi_pw("C:\\Temp\\Password.txt")
#'
#' # function is best used in a connection string command:
#' ch <- odbcConnect("some dsn", uid = "user1", pwd = decrypt_dpapi_pw("C:\\Temp\\Password.txt"))
#' }
#' @export
decrypt_dpapi_pw <- function(file) {
  # Test OS is Windows
  stopifnot(.Platform$OS.type == "windows")
  if (missing(file)) {
    warning("encrypted file argument must be defined")
  } else {
    # construct command
    command <- paste('powershell -command "$PlainPassword = Get-Content ', file, '; $SecurePassword = ConvertTo-SecureString $PlainPassword; $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword); $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR); echo $UnsecurePassword"', sep='')
    # execute powershell and return command
    invisible(system(command, intern=TRUE))
  }
}
