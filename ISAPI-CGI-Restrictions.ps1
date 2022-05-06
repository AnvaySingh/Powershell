#To add a restriction

Add-WebConfiguration -filter "system.webServer/security/isapiCgiRestriction" -value @{description='ASPNET4';path='%windir%\Microsoft.NET\Framework64\v2.0.50727\aspnet_isapi.dll';allowed='True'}

#To check if the restriction is present by path
#If not add it

$checkifenabled=Get-WebConfiguration system.webServer/security/isapiCgiRestriction/* | where {$_.path -eq "%windir%\Microsoft.NET\Framework64\v2.0.50727\aspnet_isapi.dll"}
if(!$checkifenabled)
{
Add-WebConfiguration -filter "system.webServer/security/isapiCgiRestriction" -value @{description='ASPNET4';path='%windir%\Microsoft.NET\Framework64\v2.0.50727\aspnet_isapi.dll';allowed='True'}
}

#To update and set restriction to allowed

Set-WebConfiguration '/system.webServer/security/isapiCgiRestriction/add[@path="%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll"]/@allowed' -value 'True'
