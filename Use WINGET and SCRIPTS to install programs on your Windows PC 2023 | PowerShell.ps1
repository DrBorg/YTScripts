#======================================================================
# NO POWERSHELL WINDOW DURING THE INSTALL
#======================================================================
  $t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
  add-type -name win -member $t -namespace native
  [native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

#======================================================================
# CHECK IF THE SCRIPT IS ELEVATED / ELEVATE IF NOT
#======================================================================
  If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
  {
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Exit
  }

#======================================================================
# TURN OFF PROGRESS BAR TO MAKE SCRIPT RUN FASTER
#======================================================================

  $ProgressPreference = 'SilentlyContinue'

#======================================================================
# BYPASS EXECUTION POLICY TO ALLOW SCRIPT TO RUN
#======================================================================

  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  
  # Check if winget is installed
          Write-Host "Checking if Winget is Installed..."
          if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
              #Checks if winget executable exists and if the Windows Version is 1809 or higher
              Write-Host "Winget Already Installed"
          }
          else {
              #Gets the computer's information
              $ComputerInfo = Get-ComputerInfo
  
              #Gets the Windows Edition
              $OSName = if ($ComputerInfo.OSName) {
                  $ComputerInfo.OSName
              }else {
                  $ComputerInfo.WindowsProductName
              }
  
              if (((($OSName.IndexOf("LTSC")) -ne -1) -or ($OSName.IndexOf("Server") -ne -1)) -and (($ComputerInfo.WindowsVersion) -ge "1809")) {
                  
                  Write-Host "Running Alternative Installer for LTSC/Server Editions"
  
                  # Switching to winget-install from PSGallery from asheroto
                  # Source: https://github.com/asheroto/winget-installer
                  
                  Start-Process powershell.exe -Verb RunAs -ArgumentList "-command irm https://raw.githubusercontent.com/ChrisTitusTech/winutil/$BranchToUse/winget.ps1 | iex | Out-Host" -WindowStyle Normal
                  
              }
              elseif (((Get-ComputerInfo).WindowsVersion) -lt "1809") {
                  #Checks if Windows Version is too old for winget
                  Write-Host "Winget is not supported on this version of Windows (Pre-1809)"
              }
              else {
                  #Installing Winget from the Microsoft Store
                  Write-Host "Winget not found, installing it now."
                  Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
                  $nid = (Get-Process AppInstaller).Id
                  Wait-Process -Id $nid
                  Write-Host "Winget Installed"
              }
          }
  
  # installing google chrome via winget
  winget install google.chrome  -h --accept-package-agreements --accept-source-agreements
