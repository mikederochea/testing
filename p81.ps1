# Save this script as Perimeter81.ps1

# Combine all arguments into a single string
$arguments = $args -join " "

# Run Perimeter81.exe with the combined arguments
Start-Process -FilePath "C:\Program Files\Perimeter 81\Perimeter81.exe" -ArgumentList $arguments -NoNewWindow -Wait