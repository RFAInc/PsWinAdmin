function Remove-FileByStringMatch{
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]
        $directory = ($pwd.Path)
        ,[string]
        $logPath = "$($pwd.Path)\RemovedFileLog$(Get-Date -Format yyyy-MM-dd-hh:mm).txt"
        ,[string]
        $matchString = ".eking"
    )

    Process{
        #Write-Host "Operating on directory $directory"
        $itemList = Get-ChildItem $filePath -Recurse

        foreach($item in $itemList){
            if(Test-Path $item.FullName -PathType Leaf){
                #Write-Host "Matched File for $($item.FullName), testing"
                if ($item.FullName -match $matchString){
                    try{
                        Remove-Item -Path $item.FullName -Force
                        Out-File -InputObject "Found and removed $($item.FullName)" -FilePath $logPath -Append
                        }
                    catch{
                        Out-File -InputObject "UNABLE TO REMOVE $($item.FullName)" -FilePath $logPath -Append
                    }
                }
            }
        }
    
    }
}