::BTCZTools v1.1 by zalpader
@echo off
set wallet_name=bitcoinz-windows-wallet_2.0.8_win64.zip
set version=BitcoinZ Wallet 2.0.8
set URL=https://github.com/btcz/bitcoinz-wallet/releases/download/v2.0.8/bitcoinz-windows-wallet_2.0.8_win64.zip
set DATE_TIME=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set DATE_TIME=%DATE_TIME: =0%
cls
:menu
echo [1] Install %version%
echo [2] Uninstall %version%
echo [3] Uninstall blockchain 
echo [4] Uninstall all
echo [5] Backup blockchain
echo [6] Backup wallet.dat
echo [7] Backup wallet.dat with a password
echo [8] Run command line BitcoinZ Node
echo [9] Run reindex blockchain
echo [10] Reset 50 backup transactions count message
echo.
set /P input=""
if %input% == 1 (goto wallet_install)
if %input% == 2 (goto wallet_uninstall)
if %input% == 3 (goto blockchain_uninstall)
if %input% == 4 (goto uninstall_all)
if %input% == 5 (goto blockchain_backup)
if %input% == 6 (goto wallet_backup)
if %input% == 7 (goto wallet_pass_backup)
if %input% == 8 (goto node)
if %input% == 9 (goto reindex)
if %input% == 10 (goto transactions_count_message)
goto menu

:wallet_install
if exist "%cd%\data\%wallet_name%" (
    goto unpack
) else (
    goto download
)
:exit
exit
:already_installed
echo.
echo %version% already installed!
echo.
goto menu
:download
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --dir=%cd%\data\ "%URL%"
:unpack
if exist "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet" (
    goto already_installed
)
%cd%\data\7z.exe x %cd%\data\%wallet_name% -o"C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet"
if exist "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet" (
    goto CreateShortcut
)
:CreateShortcut
@echo off
xcopy "%cd%\data\btcz.ico" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet" /E /i /y
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%userprofile%\Desktop\BitcoinZ Wallet.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinz-wallet.exe" >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet" >> CreateShortcut.vbs
echo oLink.Description = "%version%" >> CreateShortcut.vbs
echo oLink.IconLocation = "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\btcz.ico" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs
::skip wallet backup message
if not exist "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet" mkdir "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet"
xcopy "%cd%\data\transactionsCountSinceBackup.txt" "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet" /E /i /y
xcopy "%cd%\data\initialInfoShown_0.75.flag" "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet" /E /i /y
::BTCZTools Support
xcopy "%cd%\data\addressBook.csv" "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet" /E /i /y
echo.
echo %version% installed successfully!
echo.
goto menu

:wallet_uninstall
del /f/q "C:\Users\%USERNAME%\Desktop\BitcoinZ Wallet.lnk"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet"
echo.
echo %version% deleted successfully!
echo.
goto menu

:blockchain_uninstall
%cd%\data\7z.exe a "%cd%\wallet.dat_backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ"
echo.
echo Your wallet.dat has been saved in a folder %cd%\wallet.dat_backup_%DATE_TIME%.7z
echo Blockchain folder deleted successfully!
echo.
goto menu

:uninstall_all
del /f/q "C:\Users\%USERNAME%\Desktop\BitcoinZ Wallet.lnk"
%cd%\data\7z.exe a "%cd%\wallet.dat_backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\ZcashParams"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet"
echo.
echo Your wallet.dat has been saved in a folder %cd%\wallet.dat_backup_%DATE_TIME%.7z
echo %version% and blockchain deleted successfully!
echo.
goto menu

:blockchain_backup
%cd%\data\7z.exe a "%cd%\BitcoinZ_Blockchain_Backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\blocks" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\chainstate" -mx9
echo.
echo Your blockchain has been saved in a folder %cd%\BitcoinZ_Blockchain_Backup_%DATE_TIME%.7z
echo.
goto menu

:wallet_backup
%cd%\data\7z.exe a "%cd%\wallet.dat_backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
echo.
echo Your wallet.dat has been saved in a folder %cd%\wallet.dat_backup_%DATE_TIME%.7z
echo.
goto menu

:wallet_pass_backup
set /P pass_input="set a password for the archive:"
%cd%\data\7z.exe a "%cd%\wallet.dat_pass_backup_%DATE_TIME%.7z" -p"%pass_input%" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
echo.
echo Your wallet.dat with a password has been saved in a folder %cd%\wallet.dat_pass_backup_%DATE_TIME%.7z
echo.
goto menu

:node
start "BTCZ Node" C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinzd.exe -printtoconsole
goto exit

:reindex
start "BTCZ Reindex" C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinzd.exe -printtoconsole -reindex
goto exit

:transactions_count_message
xcopy "%cd%\data\transactionsCountSinceBackup.txt" "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet" /E /i /y
echo.
echo Done! It will not bother you for the next 50 transactions!
echo.
goto menu
