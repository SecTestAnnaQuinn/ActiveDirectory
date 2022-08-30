param( [Parameter(Mandatory=$true)] $JSONFile)

$json = ( Get-Content $JSONFile | ConvertFrom-Json )
echo = $json.users