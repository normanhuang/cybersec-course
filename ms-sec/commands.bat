REM Force a Group Policy Update on a client in a domain.
gpupdate /force

REM View Group Policy Sync Summary (Resultant Set of Policy (RsoP))
gpresult /R

REM All sorts of network information
net

REM Password policy
net accounts

REM Add a new user
net user newuuser newpassword /Add

REM Add a new localgroup
net user "New Local Group" /Add

REM Add a user to a localgroup
net localgroup "New Local Group" newuser /Add

REM Show all local users
net user

REM Delete a user
net user newuser /Delete

REM Delete the localgroup
net localgroup "New Local Group" /Delete

REM Display mapped drives
net share