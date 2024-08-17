
# Set paths for downloads and installations
$tempPath = "C:\Users\mike\Temp"
$pythonInstaller = "$tempPath\python_installer.exe"
$loginInstaller = "$tempPath\login.py"
$pythonInstallDir = "$tempPath\Python311"
$chromeInstaller = "$tempPath\chrome_installer.exe"
$perimeterInstaller = "$tempPath\Perimeter81_10.5.2.1979.msi"
$ubuntuIso = "$tempPath\ubuntu-desktop.iso"
$webdriverZip = "$tempPath\chromedriver_win32.zip"

# URLs for downloads
$chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$pythonUrl = "https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe" # Update the version as needed
$loginUrl = "https://raw.githubusercontent.com/mikederochea/testing/main/login.py"
$perimeterUrl = "https://static.perimeter81.com/agents/windows/Perimeter81_10.5.2.1979.msi"
$ubuntuIsoUrl = "https://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso"
$webdriverUrl = "https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_win32.zip"

# Download Perimeter 81 MSI installer
Write-Host "Downloading Perimeter 81 installer..."
Invoke-WebRequest -Uri $perimeterUrl -OutFile $perimeterInstaller

# Install Perimeter 81 with workspace
if (Test-Path $perimeterInstaller) {
    Write-Host "Installing Perimeter 81..."
    Start-Process msiexec.exe -ArgumentList "/i `"$perimeterInstaller`" /quiet WORKSPACE=$WORKSPACE" -Wait
} else {
    Write-Host "Download of Perimeter 81 failed."
}

# Download Chrome installer
Write-Host "Downloading Chrome..."
Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeInstaller

# Install Chrome
Write-Host "Installing Chrome..."
Start-Process -FilePath $chromeInstaller -ArgumentList "/silent /install" -Wait

# Download Chrome WebDriver
Write-Host "Downloading Chrome WebDriver..."
Invoke-WebRequest -Uri $webdriverUrl -OutFile $webdriverZip

# Extract Chrome WebDriver
Write-Host "Extracting Chrome WebDriver..."
Expand-Archive -Path $webdriverZip -DestinationPath "$tempPath\chromedriver" -Force

# Download Python installer
Write-Host "Downloading Python..."
Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller

# Install Python to C:\Temp\Python311
Write-Host "Installing Python..."
Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=0 TargetDir=$pythonInstallDir" -Wait

# Full paths to Python and pip
$pythonExePath = "$pythonInstallDir\python.exe"
$pipExePath = "$pythonInstallDir\Scripts\pip.exe"

# Add Python and pip to system PATH for the current session
#$env:Path = "$pythonInstallDir;$pythonInstallDir\Scripts;$env:Path"

# Install Python packages
Write-Host "Installing Python packages..."
& $pipExePath install selenium webdriver-manager

# Execute the Python script
Write-Host "Running Python script..."
& $pythonExePath $loginInstaller  # Replace 'login.py' with the path to your Python script

Write-Host "Installation and script execution completed!"

