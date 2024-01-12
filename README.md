# ubuntu-pc-setup
Scripted installation of Ubuntu developer PC

## Windows

In an elevated Powershell run:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mpeki/ubuntu-pc-setup/main/installUbuntuWSL.ps1'))
```