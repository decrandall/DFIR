<#

Kansa Script Get-ASEPImagePathLaunchStringMD5UnsignedStack.ps1 needs a dependency "logparser.exe" and is busted for logparser 2.2

Use this native Powershell version instead

Place this ps1 in a directory with as many autorunsc files as you can feed it.

#>

$autorunscCompiled = Get-ChildItem | ?{$_.Name -like "*Autorunsc.csv"} | %{import-csv $_.FullName} 

$groupedresults = $autorunscCompiled | ?{$_.Signer -notlike "(Verified)*" -and $_."Image Path" -notlike "File not found*"}| group "Image Path","Launch String","Md5","Signer" 

$results = $groupedresults |  Select @{n="ct";e={$_.count}}, @{n="Image Path";e={@($_.group."Image Path")[0]}},@{n="Launch String";e={@($_.group."Launch String")[0]}},@{n="MD5";e={@($_.group."MD5")[0]}},@{n="Signer";e={@($_.group."Signer")[0]}}

#change the output file name below if you like

$results | sort ct | Export-Csv -NoTypeInformation .\asep-workstation-stack.csv