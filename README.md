# keyringr

## Overview
keyringr is an R package that provides access to the Gnome Keyring and the Windows Data Encryption API (DPAPI).  A typical use case would be to call on of the keyringr functions to supply the password for a database connection string.  For example:

```r
# Windows - call decrypt_dpapi_pw() to get password from file containing text encrypted with DPAPI
channel <- odbcConnect("test", uid="ripley", pwd=decrypt_dpapi_pw("c:\\passwords\\test.dat"))

# Linux - call decrypt_gk_pw() to get password form Gnome Keyring
channel <- odbcConnect("test", uid="ripley", pwd=decrypt_gk_pw("db test uid ripley"))
```

## decrypt_dpapi_pw()
This function utilises the [Windows Data Protection API](https://msdn.microsoft.com/en-us/library/ms995355.aspx).  Passwords must be encrypted via PowerShell prior to using the R function.  The following command encrypts a password and saves the encrypted string to c:\Temp\Password.txt:

```powershell
Read-Host "Password" -AsSecureString |  ConvertFrom-SecureString | Out-File "C:\\Temp\\Password.txt"
```
