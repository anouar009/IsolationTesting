# Set the target folder
$targetFolder = "$env:USERPROFILE\Documents"

# Generate 5 .txt files
1..5 | ForEach-Object { "This is sample text file $_" | Out-File "$targetFolder\test_$_.txt" }

# Generate 5 empty .docx files
1..5 | ForEach-Object { New-Item -Path $targetFolder -Name "test_$_.docx" -ItemType File }

# Generate 5 empty .xlsx files
1..5 | ForEach-Object { New-Item -Path $targetFolder -Name "test_$_.xlsx" -ItemType File }

# Generate 5 fake PDF files with text content
1..5 | ForEach-Object { "PDF file simulation $_" | Out-File "$targetFolder\test_$_.pdf" }
