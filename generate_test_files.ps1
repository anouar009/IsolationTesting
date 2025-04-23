# Set the target folder
$targetFolder = "$env:USERPROFILE\Documents"

# Generate 5 .txt files with content
1..5 | ForEach-Object { "This is sample text file $_" | Out-File "$targetFolder\test_$_.txt" }

# Generate 5 .docx files with sample content
1..5 | ForEach-Object {
    $doc = New-Object -ComObject Word.Application
    $document = $doc.Documents.Add()
    $range = $document.Content
    $range.Text = "This is a sample Word document $_"
    $document.SaveAs([ref] "$targetFolder\test_$_.docx")
    $document.Close()
    $doc.Quit()
}

# Generate 5 .xlsx files with sample content
1..5 | ForEach-Object {
    $excel = New-Object -ComObject Excel.Application
    $workbook = $excel.Workbooks.Add()
    $worksheet = $workbook.Worksheets.Item(1)
    $worksheet.Cells.Item(1, 1) = "This is a sample Excel file $_"
    $workbook.SaveAs([ref] "$targetFolder\test_$_.xlsx")
    $workbook.Close()
    $excel.Quit()
}

# Generate 5 fake PDF files with text content
1..5 | ForEach-Object { "PDF file simulation $_" | Out-File "$targetFolder\test_$_.pdf" }
