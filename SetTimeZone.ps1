#=================
# SET TIMEZONE
#=================
  
  # SET TIME ZONE
    Write-Host "Setting Time Zone to CST"
    Write-Host ""
    Set-TimeZone -Id "Central Standard Time"
    Write-Host "Syncing Time"
  # Specify the time server you want to synchronize with
    $timeServer = "time.windows.com"
  # Stop the Windows Time service
    Stop-Service w32time -Force
  # Configure the time service to use the specified time server
    w32tm /config /manualpeerlist:$timeServer /syncfromflags:manual /reliable:YES /update
  # Start the Windows Time service
    Start-Service w32time
  # Force synchronization
    w32tm /resync
    Write-Host "Time synchronization completed."
    Write-Host ""
