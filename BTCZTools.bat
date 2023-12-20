::BTCZTools v1.4a by zalpader
@echo off
set conf=C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\bitcoinz.conf
set version=BitcoinZ Wallet 2.0.8-EXT
set wallet_name=bitcoinz-windows-wallet_2.0.8_EXT_win64.zip
set wallet_url=https://github.com/zalpader/bitcoinz-windows-wallet_2.0.8_EXT/releases/download/2.0.8-EXT/bitcoinz-windows-wallet_2.0.8_EXT_win64.zip
set blockchain_folder=C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ
set blockchain_name_1=BitcoinZ_Blockchain_Backup_2023.12.20_14-38-31.7z
set blockchain_url_1=https://link.storjshare.io/s/jvhzhworj7ry3fnpbqfdr4ybhosq/btcz/BitcoinZ_Blockchain_Backup_2023.12.20_14-38-31.7z?download=1
set blockchain_name_2=BitcoinZ_Blockchain_Backup_2023.07.21_03-59-41.7z
set blockchain_url_2=https://link.storjshare.io/s/jwtbc6fcdkwmb27xwgju6o3r2y3q/btcz/BitcoinZ_Blockchain_Backup_2023.07.21_03-59-41.7z?download=1
set blockchain_name_3=BitcoinZ_Blockchain_Backup_2023.04.28_18-57-58.7z
set blockchain_url_3=https://link.storjshare.io/s/jvdxderwlpxyjfic6ozwjhbrgnqa/btcz/BitcoinZ_Blockchain_Backup_2023.04.28_18-57-58.7z?download=1
set blockchain_name_4=
set blockchain_url_4=
set blockchain_name_5=
set blockchain_url_5=
set DATE_TIME=%DATE:~6,4%.%DATE:~3,2%.%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set DATE_TIME=%DATE_TIME: =0%
cls
:checking
if exist "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinz-wallet.exe" (
    goto menu
) else (
    goto menu_2
)
:menu
echo [1] Uninstall %version%
echo [2] Uninstall blockchain 
echo [3] Uninstall all %version% files with blockchain
echo [4] Download and uncompress blockchain backup
echo [5] Backup blockchain
echo [6] Uncompress self blockchain backup
echo [7] Backup wallet.dat
echo [8] Backup wallet.dat with a password
echo [9] Run command line BitcoinZ Node
echo [10] Reindex blockchain
echo [11] Rescan TX
echo [12] Reset 50 backup transactions count message
echo [13] Fix 0 connections


echo.
set /P input=""
if %input% == 1 (goto wallet_uninstall)
if %input% == 2 (goto blockchain_uninstall)
if %input% == 3 (goto uninstall_all)
if %input% == 4 (goto download_backup)
if %input% == 5 (goto blockchain_backup)
if %input% == 6 (goto uncompress_backup)
if %input% == 7 (goto wallet_backup)
if %input% == 8 (goto wallet_pass_backup)
if %input% == 9 (goto node)
if %input% == 10 (goto reindex)
if %input% == 11 (goto rescan_tx)
if %input% == 12 (goto transactions_count_message)
if %input% == 13 (goto connections)


echo.
echo ERROR! Enter a number from 1 to 13!
echo.
goto checking

:menu_2
if exist "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ" (
    goto menu_3
)
echo.
echo Install the %version% with BTCZTools to access the full functionality!
echo.
echo [1] Install %version%
echo.
set /P input=""
if %input% == 1 (goto wallet_install)
echo.
echo ERROR! Enter a number 1!
echo.
goto checking

:menu_3
echo.
echo Install the %version% with BTCZTools to access the full functionality!
echo.
echo [1] Install %version%
echo [2] Uninstall blockchain 
echo [3] Uninstall all %version% files with blockchain
echo [4] Download and uncompress blockchain backup
echo [5] Backup blockchain
echo [6] Uncompress self blockchain backup
echo [7] Backup wallet.dat
echo [8] Backup wallet.dat with a password
echo [9] Fix 0 connections
echo.
set /P input=""
if %input% == 1 (goto wallet_install)
if %input% == 2 (goto blockchain_uninstall)
if %input% == 3 (goto uninstall_all)
if %input% == 4 (goto download_backup)
if %input% == 5 (goto blockchain_backup)
if %input% == 6 (goto uncompress_backup)
if %input% == 7 (goto wallet_backup)
if %input% == 8 (goto wallet_pass_backup)
if %input% == 9 (goto connections)
echo.
echo ERROR! Enter a number from 1 to 9!
echo.
goto checking

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
goto checking
:download
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --dir=%cd%\data "%wallet_url%"
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
goto checking

:wallet_uninstall
del /f/q "C:\Users\%USERNAME%\Desktop\BitcoinZ Wallet.lnk"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet"
echo.
echo %version% deleted successfully!
echo.
goto checking

:blockchain_uninstall
%cd%\data\7z.exe a "%cd%\wallet.dat_backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\blocks"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\chainstate"
del /f/q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\debug.log"
echo.
echo Your wallet.dat has been saved in a folder %cd%\wallet.dat_backup_%DATE_TIME%.7z
echo Blockchain folder deleted successfully!
echo.
goto checking

:uninstall_all
%cd%\data\7z.exe a "%cd%\wallet.dat_backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
del /f/q "C:\Users\%USERNAME%\Desktop\BitcoinZ Wallet.lnk"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Roaming\ZcashParams"
RMDIR /S /Q "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet"
echo.
echo Your wallet.dat has been saved in a folder %cd%\wallet.dat_backup_%DATE_TIME%.7z
echo %version% and blockchain deleted successfully!
echo.
goto checking

:blockchain_backup
%cd%\data\7z.exe a "%cd%\BitcoinZ_Blockchain_Backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\blocks" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\chainstate" -mx9
echo.
echo Your blockchain has been saved in a folder %cd%\BitcoinZ_Blockchain_Backup_%DATE_TIME%.7z
echo.
goto checking

:wallet_backup
%cd%\data\7z.exe a "%cd%\wallet.dat_backup_%DATE_TIME%.7z" "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
echo.
echo Your wallet.dat has been saved in a folder %cd%\wallet.dat_backup_%DATE_TIME%.7z
echo.
goto checking

:wallet_pass_backup
set /P pass_input="set a password for the archive:"
cls
%cd%\data\7z.exe a "%cd%\wallet.dat_pass_backup_%DATE_TIME%.7z" -p%pass_input% "C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ\wallet.dat" -mx9
echo.
echo Your wallet.dat with a password has been saved in a folder %cd%\wallet.dat_pass_backup_%DATE_TIME%.7z
echo.
goto checking

:node
start "BTCZ Node" C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinzd.exe -printtoconsole
goto exit

:reindex
start "BTCZ Node" C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinzd.exe -printtoconsole -reindex
goto exit

:rescan_tx
start "BTCZ Node" C:\Users\%USERNAME%\AppData\Roaming\BitcoinZ-Wallet\bitcoinzd.exe -printtoconsole -rescan
goto exit

:transactions_count_message
xcopy "%cd%\data\transactionsCountSinceBackup.txt" "C:\Users\%USERNAME%\AppData\Local\BitcoinZWallet" /E /i /y
echo.
echo Done! It will not bother you for the next 50 transactions!
echo.
goto checking

:connections
echo addnode=seed.btcz.app>> %conf%
echo addnode=btzseed.blockhub.info>> %conf%
echo addnode=btzseed2.blockhub.info>> %conf%
echo addnode=149.28.202.159:1989>> %conf%
echo addnode=85.237.189.122:1989>> %conf%
echo addnode=85.15.179.171:1989>> %conf%
echo addnode=94.237.40.36:1989>> %conf%
echo addnode=68.195.18.155:1989>> %conf%
echo addnode=37.187.226.146:1989>> %conf%
echo addnode=95.216.152.73:1989>> %conf%
echo addnode=51.75.146.76:1989>> %conf%
echo addnode=46.4.102.69:1989>> %conf%
echo addnode=173.212.253.221:1989>> %conf%
echo addnode=95.216.209.62:1989>> %conf%
echo addnode=31.40.218.121:1989>> %conf%
echo.
echo 15 nodes have been added to the file %conf%
echo Done! Launch the %version% and check if there is a connection now!
echo.
goto checking

:uncompress_backup
echo.
echo WARNING! Only 7z files made in the BTCZTools utility are accepted!
echo.
set /p user_file="Drag and drop the 7z backup file into this window and press enter: "
echo.
if exist "%blockchain_folder%\debug.log" del /f "%blockchain_folder%\debug.log"
if exist "%blockchain_folder%\blocks" rmdir /S /Q "%blockchain_folder%\blocks"
if exist "%blockchain_folder%\chainstate" rmdir /S /Q "%blockchain_folder%\chainstate"
%cd%\data\7z.exe x %user_file% -o"%blockchain_folder%"
echo.
goto checking

:download_backup
echo.
echo WARNING! Using this backup will significantly accelerate the synchronization process of your wallet and also address certain errors, such as "Activating the best chain" or other blockchain-related issues. However, it's important to note that the decision to trust this backup of the blockchain or to independently perform a full blockchain synchronization rests entirely with you!
echo.
echo [0] Return to the main menu
echo.
echo Select a file to download and press enter
echo.
if "%blockchain_name_1%"=="" (
  rem
) else (
  echo [1] Download %blockchain_name_1%
)
if "%blockchain_name_2%"=="" (
  rem
) else (
  echo [2] Download %blockchain_name_2%
)
if "%blockchain_name_3%"=="" (
  rem
) else (
  echo [3] Download %blockchain_name_3%
)
if "%blockchain_name_4%"=="" (
  rem
) else (
  echo [4] Download %blockchain_name_4%
)
if "%blockchain_name_5%"=="" (
  rem
) else (
  echo [5] Download %blockchain_name_5%
)
echo.
set /P input=""
if %input% == 0 (goto checking)
if %input% == 1 (goto dl_backup_1)
if %input% == 2 (goto dl_backup_2)
if %input% == 3 (goto dl_backup_3)
if %input% == 4 (goto dl_backup_4)
if %input% == 5 (goto dl_backup_5)
echo.
echo ERROR! Enter a number from 0 to 5!
echo.
goto download_backup

:dl_backup_1
if "%blockchain_url_1%"=="" (
  goto errors
)
if exist "%cd%\data\%blockchain_name_1%" (
    goto unpack_backup_1
)
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --file-allocation=none --dir=%cd%\data "%blockchain_url_1%"
:unpack_backup_1
if exist "%blockchain_folder%\debug.log" del /f "%blockchain_folder%\debug.log"
if exist "%blockchain_folder%\blocks" rmdir /S /Q "%blockchain_folder%\blocks"
if exist "%blockchain_folder%\chainstate" rmdir /S /Q "%blockchain_folder%\chainstate"
%cd%\data\7z.exe x "%cd%\data\%blockchain_name_1%" -o"%blockchain_folder%"
echo.
goto checking

:dl_backup_2
if "%blockchain_url_2%"=="" (
  goto errors
)
if exist "%cd%\data\%blockchain_name_2%" (
    goto unpack_backup_2
)
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --file-allocation=none --dir=%cd%\data "%blockchain_url_2%"
:unpack_backup_2
if exist "%blockchain_folder%\debug.log" del /f "%blockchain_folder%\debug.log"
if exist "%blockchain_folder%\blocks" rmdir /S /Q "%blockchain_folder%\blocks"
if exist "%blockchain_folder%\chainstate" rmdir /S /Q "%blockchain_folder%\chainstate"
%cd%\data\7z.exe x "%cd%\data\%blockchain_name_2%" -o"%blockchain_folder%"
echo.
goto checking

:dl_backup_3
if "%blockchain_url_3%"=="" (
  goto errors
)
if exist "%cd%\data\%blockchain_name_3%" (
    goto unpack_backup_3
)
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --file-allocation=none --dir=%cd%\data "%blockchain_url_3%"
:unpack_backup_3
if exist "%blockchain_folder%\debug.log" del /f "%blockchain_folder%\debug.log"
if exist "%blockchain_folder%\blocks" rmdir /S /Q "%blockchain_folder%\blocks"
if exist "%blockchain_folder%\chainstate" rmdir /S /Q "%blockchain_folder%\chainstate"
%cd%\data\7z.exe x "%cd%\data\%blockchain_name_3%" -o"%blockchain_folder%"
echo.
goto checking

:dl_backup_4
if "%blockchain_url_4%"=="" (
  goto errors
)
if exist "%cd%\data\%blockchain_name_4%" (
    goto unpack_backup_4
)
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --file-allocation=none --dir=%cd%\data "%blockchain_url_4%"
:unpack_backup_4
if exist "%blockchain_folder%\debug.log" del /f "%blockchain_folder%\debug.log"
if exist "%blockchain_folder%\blocks" rmdir /S /Q "%blockchain_folder%\blocks"
if exist "%blockchain_folder%\chainstate" rmdir /S /Q "%blockchain_folder%\chainstate"
%cd%\data\7z.exe x "%cd%\data\%blockchain_name_4%" -o"%blockchain_folder%"
echo.
goto checking

:dl_backup_5
if "%blockchain_url_5%"=="" (
  goto errors
)
if exist "%cd%\data\%blockchain_name_5%" (
    goto unpack_backup_5
)
%cd%\data\aria2c.exe -x 16 -s 16 -k 1M --file-allocation=none --dir=%cd%\data "%blockchain_url_5%"
:unpack_backup_5
if exist "%blockchain_folder%\debug.log" del /f "%blockchain_folder%\debug.log"
if exist "%blockchain_folder%\blocks" rmdir /S /Q "%blockchain_folder%\blocks"
if exist "%blockchain_folder%\chainstate" rmdir /S /Q "%blockchain_folder%\chainstate"
%cd%\data\7z.exe x "%cd%\data\%blockchain_name_5%" -o"%blockchain_folder%"
echo.
goto checking

:errors
echo.
echo Oops Something went wrong
echo.
goto download_backup
