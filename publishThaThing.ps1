# publish.ps1

# Define the publish command and the paths
$publishCommand = "dotnet publish -c Release"
$source = "WebApp\bin\Release\net8.0\publish\wwwroot"
$destination = "docs\"

# List of folders you want to copy
$foldersToCopy = @("Folder1", "Folder2", "Folder3") # Replace with the names of your folders

# Run the publish command
Invoke-Expression $publishCommand

# Create the destination directory if it doesn't exist
if (-not (Test-Path -Path $destination)) {
    New-Item -ItemType Directory -Path $destination
}

# Copy each specified folder to the destination
foreach ($folder in $foldersToCopy) {
    $sourceFolder = Join-Path $source $folder
    $destinationFolder = Join-Path $destination $folder

    if (Test-Path -Path $sourceFolder) {
        Copy-Item -Recurse -Force $sourceFolder $destinationFolder
        Write-Host "Copied $folder to $destinationFolder"
    } else {
        Write-Host "Folder $folder does not exist in the publish directory."
    }
}
