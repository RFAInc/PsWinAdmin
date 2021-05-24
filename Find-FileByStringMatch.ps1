function Find-FileByStringMatch{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]
        $matchString
        ,[string]
        $directory = ($pwd.Path)
        ,[string]
        $logPath = "$($pwd.Path)\FileLog$(Get-Date -Format yyyy-MM-dd_hh-mm).txt"
        ,[switch]
        $removeFiles
    )

    Process{
        #Write-Host "Operating on directory $directory"
        $itemList = Get-ChildItem $directory -Recurse

        foreach($item in $itemList){
            Write-Progress -Activity "Checking $($item.FullName)"
            if(Test-Path $item.FullName -PathType Leaf){
                #Write-Host "Matched File for $($item.FullName), testing"
                if ($item.FullName -match $matchString){
                    Out-File -InputObject "Found $($item.FullName)" -FilePath $logPath -Append
                    try{
                        if($removeFiles){
                            Out-File -InputObject "Removal enabled, removing $($item.FullName)" -FilePath $logPath -Append
                            Remove-Item -Path $item.FullName -Force
                        }
                    }
                    catch{
                        Out-File -InputObject "UNABLE TO REMOVE $($item.FullName)" -FilePath $logPath -Append
                    }
                }
            }
        }
    }
}