
# Set paths for downloads and installations
$tempPath = "C:\Temp"
$pythonInstaller = "$tempPath\python_installer.exe"
$loginInstaller = "$tempPath\login.py"
$pythonInstallDir = "$tempPath\Python311"

# URLs for downloads
$pythonUrl = "https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe" # Update the version as needed
$loginUrl = "https://raw.githubusercontent.com/mikederochea/testing/main/login.py"

# Create temp directory if it doesn't exist
if (-Not (Test-Path -Path $tempPath)) {
    New-Item -ItemType Directory -Path $tempPath
}

# Download login script
Write-Host "Downloading login script..."
#Invoke-WebRequest -Uri $loginUrl -OutFile $loginInstaller

# Download Python installer
Write-Host "Downloading Python..."
#Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller

# Install Python to C:\Temp\Python311
Write-Host "Installing Python..."
#Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=0 TargetDir=$pythonInstallDir" -Wait

# Full paths to Python and pip
$pythonExePath = "$pythonInstallDir\python.exe"
$pipExePath = "$pythonInstallDir\Scripts\pip.exe"

# Add Python and pip to system PATH for the current session
$env:Path = "$pythonInstallDir;$pythonInstallDir\Scripts;$env:Path"

# Install Python packages
#Write-Host "Installing Python packages..."
#& $pipExePath install selenium webdriver-manager pyautogui

# Execute the Python script
#Write-Host "Running Python script..."
& $pythonExePath $loginInstaller  # Replace 'login.py' with the path to your Python script

# Clean up
Write-Host "Cleaning up..."
#Remove-Item -Path $pythonInstaller, $loginInstaller -Force

Write-Host "Installation and script execution completed!"