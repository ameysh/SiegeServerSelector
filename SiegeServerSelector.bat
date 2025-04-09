@echo off
setlocal EnableDelayedExpansion
color 06

:: This is the path to your GameSettings.ini file
:: It is best to copy paste the entire path from the file explorer
:: Or you can replace YOURUSERNAME and YOURGAMEID with your username and game ID
set "filePath=C:\Users\YOURUSERNAME\Documents\My Games\Rainbow Six - Siege\YOURGAMEID\GameSettings.ini"

for /f "tokens=2 delims==" %%a in ('findstr /b "DataCenterHint=" "%filePath%"') do (
    set "currentServer=%%a"
)

:MENU
cls
echo ========================================
echo         FW R6 Server Switcher         
echo ========================================
echo.
echo Current Server: !currentServer!
echo.

:: Recommended Servers (0-4)
echo FW's Commonly Selected Servers:
echo  0. Default (Ping based)
echo  1. Australia East
echo  2. Southeast Asia
echo  3. UAE North
echo  4. West Europe
echo.

:: Other Servers (5-13)
echo Other Servers:
echo  5. Brazil South
echo  6. Central US
echo  7. East Asia
echo  8. East US
echo  9. Japan East
echo 10. North Europe
echo 11. South Africa North
echo 12. South Central US
echo 13. West US
echo.

set /p choice=Select a server (0-13): 

set "server="
if "%choice%"=="0" set server=default
if "%choice%"=="1" set server=playfab/australiaeast
if "%choice%"=="2" set server=playfab/southeastasia
if "%choice%"=="3" set server=playfab/uaenorth
if "%choice%"=="4" set server=playfab/westeurope
if "%choice%"=="5" set server=playfab/brazilsouth
if "%choice%"=="6" set server=playfab/centralus
if "%choice%"=="7" set server=playfab/eastasia
if "%choice%"=="8" set server=playfab/eastus
if "%choice%"=="9" set server=playfab/japaneast
if "%choice%"=="10" set server=playfab/northeurope
if "%choice%"=="11" set server=playfab/southafricanorth
if "%choice%"=="12" set server=playfab/southcentralus
if "%choice%"=="13" set server=playfab/westus

if not defined server (
    echo.
    echo Invalid choice
    pause
    goto MENU
)

echo.
echo Updating GameSettings.ini...
powershell -Command "(Get-Content '%filePath%') -replace 'DataCenterHint=.*', 'DataCenterHint=%server%' | Set-Content '%filePath%'"

color 06
echo.
echo Server has been changed to: %server%
timeout /t 2 >nul
exit
