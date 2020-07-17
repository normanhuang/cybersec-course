<#
Practising queries in powershell.
Assumes machine is in cyber.com domain
#>

Set-ExecutionPolicy bypass
$ErrorActionPreference='Stop'
# Create test users
$scriptTestUsers = 'Betty','Archie','Veronica'
$scriptTestUsers.ForEach(
{
   try
   { 
        New-ADUser –Name $_ –SamAccountName $_ –path “OU=IT, DC=cyber, DC=com” -Server Server1
   }
   catch [Microsoft.ActiveDirectory.Management.ADIdentityAlreadyExistsException]
   {
        echo "$_"
   }
   catch
   {
    echo "woopsie"
   }
   
})


$ad_users = Get-ADUser -Filter *
$ad_domain = Get-ADDomain

'---- Project the name, and netbiosname ----'
$ad_domain | select Name, netbiosname

'---- Filtering ----'
$ad_users | where Name -Like 'Ver*'
$ad_users | where {$_.Name -like 'ver*' -and $_.ObjectGUID -ne 'blahblahblah'}
$ad_users | where {$_.Name -in "Archie","Betty"}
$ad_users.Where({$_.Name -like "bet*"}, 'First')

'---- Sort ----'
$ad_users | sort Name

'---- Group ----'
$grouped = $ad_users | group ObjectClass
echo $grouped
'count: ' + $grouped.Count

'---- Removing Users ----'
$scriptTestUsers.ForEach(
{
try
{
    Remove-ADUser $_ -Confirm:$False # shunts the confirm window
    echo "Removed $_"
 }
 catch
 {
  'Woopsie'
 }   
})