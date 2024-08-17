
# Set paths for downloads and installations
$tempPath = "C:\Users\mike\Temp"
$loginInstaller = "$tempPath\login.py"
$pythonInstallDir = "$tempPath\Python311"

# Full paths to Python and pip
$pythonExePath = "$pythonInstallDir\python.exe"
$pipExePath = "$pythonInstallDir\Scripts\pip.exe"

# Execute the Python script
Write-Host "Running Python script..."
& $pythonExePath $loginInstaller  # Replace 'login.py' with the path to your Python script

Write-Host "Installation and script execution completed!"