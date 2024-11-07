#=========================================
#  DOWNLOADING AND INSTALL APP FROM WEB
#=========================================
  #Turns off progress
    $ProgressPreference = 'SilentlyContinue'

  # Grabbing a download from a website.
      # Set path where the download will go
      # Make sure to attach the correct extension (.exe, .msi, .etc)
      Write-Host "Downloading File..."
      Write-Host ""
      $UserPath1 = "$($env:USERPROFILE)\Downloads\speccyinstall.exe"
      Invoke-WebRequest -Uri "https://download.ccleaner.com/spsetup133.exe" -OutFile "$UserPath1"
      Write-Host "Download Complete."
      Write-Host ""
  
  # # Installing a .MSI
  #     Write-Host "Starting Install..."
  #     Write-Host ""
  #     msiexec /i $UserPath1 /quiet /passive
  #     Write-Host "Install Finished"
  
  # Installing a .EXE
      Write-Host "Starting Install..."
      Write-Host ""
      Start-Process -FilePath "$UserPath1" -ArgumentList "/S" -PassThru -NoNewWindow -Wait;
      Write-Host "Install Finished"
  
  # Removing Download if needed
      Write-Host "Deleting Download..."
      Write-Host ""
      Remove-Item $UserPath1
      Write-Host "Download Deleted"
