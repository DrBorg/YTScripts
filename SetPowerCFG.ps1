#===================================
# SET SCREEN | SLEEP | HIBERNATE
#===================================

# CHANGE SCREEN OFF @ 45-MIN AND SLEEP AND HIBERNATE TO OFF
    Write-Host "Setting Screen off to 45 minutes"
    Write-Host "Setting Sleep to Never if on AC power (charger / power chord)"
    Write-Host "Setting Sleep to 60 minutes if on DC power (battery)"
    Write-Host "Turning Hibernation Off"
    Powercfg /Change monitor-timeout-ac 45
    Powercfg /Change monitor-timeout-dc 45
    Powercfg /Change standby-timeout-ac 0
    Powercfg /Change standby-timeout-dc 60
    powercfg /hibernate off
    Write-Host ""
