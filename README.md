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
This function utilises the [Windows Data Protection API](https://msdn.microsoft.com/en-us/library/ms995355.aspx).  Passwords must be encrypted via PowerShell prior to using the R function.  The following command encrypts a password and saves the encrypted string to `C:\Temp\Password.txt`:

```powershell
Read-Host "Password" -AsSecureString |  ConvertFrom-SecureString | Out-File "C:\\Temp\\Password.txt"
```

This produces an encrypted string, which can only be decrypted by the same user and computer that encrypted the password.  This means that the command above must be executed on each PC that the function will be used on.

It can be useful to store the encrypted password files in a standardised directly, such as `C:\Users\username\DPAPI\computer_name\`  This can be achieved with the following PowerShell script:

```powershell
put script here!!!
```

## decrypt_gk_pw()
This function utilises the Gnome Keyring and [secret-tool](http://manpages.ubuntu.com/manpages/trusty/man1/secret-tool.1.html).  Passwords must be initially stored in the Keyring using a command in the following format:

```bash
put script here!!
```


