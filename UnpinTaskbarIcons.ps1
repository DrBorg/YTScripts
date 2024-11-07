#================================
# UNPIN ALL TASKBAR ICONS
#================================

# Remove all files inside the Taskbar APPDATA folder
#================================
  Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force -Recurse -ErrorAction SilentlyContinue

# Remove the Taskband Registry Key to delete taskbar data for recent apps.
#================================
  Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force -Recurse -ErrorAction SilentlyContinue

#Start-Stop the File Explorer to refresh the taskbar.
#================================
  Stop-Process -ProcessName explorer -Force
  Start-Process explorer
