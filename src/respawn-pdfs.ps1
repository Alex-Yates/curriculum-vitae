Add-type -AssemblyName office -ErrorAction SilentlyContinue
Add-Type -AssemblyName microsoft.office.interop.powerpoint -ErrorAction SilentlyContinue

Set-Location "$PSScriptRoot"

$sourceFilesDir = "."
$outputFileDir = $PSScriptRoot -replace ("src", "bin")

if(Test-Path $outputFileDir){
    Remove-Item $outputFileDir -Force -Recurse
}

New-Item -ItemType Directory $outputFileDir

$ppt = New-Object -com powerpoint.application
$opt = [Microsoft.Office.Interop.PowerPoint.PpSaveAsFileType]::ppSaveAsPDF

Get-ChildItem $sourceFilesDir -Filter '*.pptx' | ForEach-Object {
     $srcFileName = $_.Name
     $outFileName = $srcFileName -replace (".pptx", ".pdf")
     $srcFile = $_.FullName
     $outFile = Join-Path -Path $outputFileDir -ChildPath $outFileName
     Write-Output "Converting $srcFile to PDF. Saving to $outFile"
     $pres = $ppt.Presentations.Open($srcFile)
     $pres.SaveAs($outFile, $opt)
}