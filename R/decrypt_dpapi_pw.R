#' Decrypt passwords encrypted with  the Microsoft Data Protection API
#' @param file File that holds a password encrypted using DPAPI
#' @export
decrypt_dpapi_pw <- function(file) {
  stopifnot(.Platform$OS.type == "windows")
  if (missing(file)) {
    warning("encrypted file argument must be defined")
  } else {
    # construct command
    command <- paste('powershell -command "$PlainPassword = Get-Content ', file, '; $SecurePassword = ConvertTo-SecureString $PlainPassword; $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword); $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR); echo $UnsecurePassword"', sep='')
    # execute powershell and return command
    return(invisible(system(command, intern=TRUE)))
  }
}
