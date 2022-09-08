Remove-Item "C:\Users\ycz017\AppData\Roaming\Mozilla\Firefox\Profiles\qzzmbaor.default-release" -Recurse -Force -Confirm:$false;
Copy-Item -Path "D:\qzzmbaor.default-release" -Destination "C:\Users\ycz017\AppData\Roaming\Mozilla\Firefox\Profiles" -Recurse;

# sets up all the download links & paths
$intj_dwn = "https://download-cdn.jetbrains.com/idea/ideaIC-2022.2.1.exe"
$intj_pth = "C:\Users\ycz017\Downloads\ideaIC.exe"
$intj_cfg_dwn = "https://download-cdn.jetbrains.com/idea/silent.config"
$intj_cfg_pth = "C:\Users\ycz017\Downloads\silent.config"
$intj_exe = "C:\Users\ycz017\Downloads\ideaIC.exe /S /CONFIG="+$intj_cfg_pth

# downloads files to provided paths
$webclient = new-object System.Net.WebClient
$webclient.DownloadFile($intj_dwn, $intj_pth)
$webclient.DownloadFile($intj_cfg_dwn, $intj_cfg_pth);

# modifies config file to install jre and add java file associations
((Get-Content -Path $intj_cfg_pth -Raw) -replace 'jre32=0', 'jre32=1') |
Set-Content -Path $intj_cfg_pth
((Get-Content -Path $intj_cfg_pth -Raw) -replace '.java=0', '.java=1') |
Set-Content -Path $intj_cfg_pth

# installs
Invoke-Expression $intj_exe
