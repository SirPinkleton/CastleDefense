﻿function csvExists($fileToCheck)
{
    $listOfCurrentCsvs = Get-ChildItem | Where-Object {$_.FullName -match ".csv"}
    foreach ($file in $listOfCurrentCsvs)
    {
        $fileName = $file.Name
        Write-Host "###checking if '$fileName' is equal to '$fileToCheck'"
        if($fileName -eq $fileToCheck)
        {
            return $true
        }
    }
    return $false
}


#remove all old output folders
Write-Host "removing old output folders"
Write-Host "+++++++++++++++++++++++++++"
$listOfOutputFolders = Get-ChildItem | Where-Object {$_.FullName -match "_output"}
foreach ($outputFolder in $listOfOutputFolders)
{
    remove-item $outputFolder -force -recurse -ErrorAction SilentlyContinue
}

#generate new output folders
$listOfCardDocuments = Get-ChildItem | Where-Object {$_.FullName -match ".csv"}
write-host ""
Write-Host "iterating over documents to generate card pngs"
$failureFound = $false
foreach ($cardDocument in $listOfCardDocuments)
{
    if ($failureFound)
    {
        exit
    }
    write-host ""
    Write-Host "working on $cardDocument"
    Write-Host "+++++++++++++++++++++++++++++++++"

    $csvNameOfDocument = $cardDocument.Name
    Write-Host "__csv version of input file: $csvNameOfDocument"

    if(csvExists($csvNameOfDocument))
    {
        Write-Host "executing ruby script on the generated csv"
        Write-Host "++++++++++++++++++++++++++++++++++++++++++"
        ruby generate-herocards.rb $csvNameOfDocument

        $xlsxNameOfDocument -match "_Data-(?<content>.*).xlsx"
        $docShortName = $matches['content']

        $outputDirName = resolve-path _output -ErrorAction SilentlyContinue
        if(test-path $outputDirName)
        {
            Write-Host "____output folder generated, renaming it for parsability"
            $newOutputDirName = $outputDirName -replace "_output","_output-$docShortName"

            #rename folder
            rename-item $outputDirName $newOutputDirName
        }
        else
        {
            Write-Host "____output folder not generated"
            $failureFound = $true
        }
        #delete old csv
        Write-Host "____removing old csv"
        remove-item $csvNameOfDocument
    }
    else
    {
        Write-Host "____failed to generate csv"
        $failureFound = $true
    }
    Write-Host "--------------------"
}
if ($failureFound)
{
    Write-Host "ran into an error, ending early"
}