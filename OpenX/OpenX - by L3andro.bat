@echo off
title OpenX - by L3andro
chcp 65001 >nul
color 3

:: Your current version
set "CURRENT_VERSION=1.0.2"

:: Check if "programs" folder exists
if exist programs (
    cd programs
) else (
    echo [ERROR] "programs" folder not found.
    pause
    exit
)

:menu
cls
call :banner
call :check_update

:: Main menu
echo.
echo       (1)- Discord
echo       (2)- Steam
echo       (3)- Voidstrap
echo       (4)- Epic Games Launcher
echo       (5)- Razer Cortex
echo.

set /p input=Select an option: 

if /I "%input%"=="1" (
    start Discord
) else if /I "%input%"=="2" (
    start Steam
) else if /I "%input%"=="3" (
    start Voidstrap
) else if /I "%input%"=="4" (
    start EGLauncher
) else if /I "%input%"=="5" (
    start cortex
) else (
    echo [!] Invalid option. Please try again.
    timeout /t 2 >nul
)

goto menu

:banner
echo.
echo            ██████╗ ██████╗ ███████╗███╗   ██╗██╗  ██╗
echo           ██╔═══██╗██╔══██╗██╔════╝████╗  ██║╚██╗██╔╝
echo           ██║   ██║██████╔╝█████╗  ██╔██╗ ██║ ╚███╔╝ 
echo           ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║ ██╔██╗ 
echo           ╚██████╔╝██║     ███████╗██║ ╚████║██╔╝ ██╗
echo            ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝ v %CURRENT_VERSION%
echo.
goto :eof

:check_update
setlocal enabledelayedexpansion
set "GITHUB_API=https://api.github.com/repos/l3andromarqu3s/OpenX/releases/latest"

echo Checking for updates...

for /f "usebackq tokens=*" %%A in (`curl -s %GITHUB_API% ^| findstr /i "tag_name"`) do (
    set "line=%%A"
)

for /f "tokens=2 delims=:," %%V in ("!line!") do set "LATEST_VERSION=%%~V"
set "LATEST_VERSION=!LATEST_VERSION:"=!"
set "LATEST_VERSION=!LATEST_VERSION: =!"

if /i "!LATEST_VERSION:~0,1!"=="v" set "LATEST_VERSION=!LATEST_VERSION:~1!"

call :version_greater "!LATEST_VERSION!" "%CURRENT_VERSION%"
if !errorlevel! == 1 (
    echo.
    echo *** A new version is available on GitHub! ***
    echo     Current version: %CURRENT_VERSION%
    echo     Latest version:  !LATEST_VERSION!
    echo     Link: https://github.com/l3andromarqu3s/OpenX
    echo.
) else (
    echo You are using the latest version.
)
endlocal
goto :eof

:version_greater
:: Compares version strings (v1 > v2 = return 1; else 0)
setlocal
set "ver1=%~1"
set "ver2=%~2"

for /f "tokens=1-3 delims=." %%a in ("%ver1%") do (
    set "v1_1=%%a"
    set "v1_2=%%b"
    set "v1_3=%%c"
)
for /f "tokens=1-3 delims=." %%a in ("%ver2%") do (
    set "v2_1=%%a"
    set "v2_2=%%b"
    set "v2_3=%%c"
)

if not defined v1_2 set "v1_2=0"
if not defined v1_3 set "v1_3=0"
if not defined v2_2 set "v2_2=0"
if not defined v2_3 set "v2_3=0"

if %v1_1% GTR %v2_1% exit /b 1
if %v1_1% LSS %v2_1% exit /b 0
if %v1_2% GTR %v2_2% exit /b 1
if %v1_2% LSS %v2_2% exit /b 0
if %v1_3% GTR %v2_3% exit /b 1
exit /b 0
