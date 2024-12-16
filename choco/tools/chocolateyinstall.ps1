$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/kubeclick/kubeclick/releases/download/v0.1.0/kc-windows-amd64.exe'
  checksum64     = 'bb6f55e74ebb6a60611974247056280cd7cb4a149a0b419cd9cb3e123020cedd'
  checksumType64 = 'sha256'
  destination    = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

# Create a shim for the executable
$files = Get-ChildItem $toolsDir -include *.exe -recurse
$fullPath = $files[0].FullName
Install-BinFile -Name "kc" -Path $fullPath
