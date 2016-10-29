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
Notes here...

