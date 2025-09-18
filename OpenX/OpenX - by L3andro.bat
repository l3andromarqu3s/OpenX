@echo off
title OpenX - by L3andro
chcp 65001 >nul
color 3

:: Your current version
set "CURRENT_VERSION=1.1.0"

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

:: Check for updates from GitHub
call :check_update

:: Define backspace symbol
for /f %%A in ('"prompt $H & echo on & for %%B in (1) do rem"') do set BS=%%A

:: Stylized Menu
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                      MAIN MENU - OpenX                     ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║  (1) Discord                                               ║
echo ║  (2) Steam                                                 ║
echo ║  (3) Voidstrap                                             ║
echo ║  (4) Epic Games Launcher                                   ║
echo ║  (5) Razer Cortex                                          ║
echo ║  (6) Other Options                                         ║
echo ║  (0) Exit                                                  ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set /p input=.%BS%

:: Main menu actions
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
) else if /I "%input%"=="6" (
    goto other_options
) else if /I "%input%"=="0" (
    exit
) else (
    echo [!] Invalid option. Please try again.
    timeout /t 2 >nul
)

goto menu

:other_options
cls
call :banner

:: Stylized Other Options menu
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                    OTHER OPTIONS - OpenX                   ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║  (1) Shut down PC                                          ║
echo ║  (2) Restart PC                                            ║
echo ║  (3) Check internet connection                             ║
echo ║  (4) Back to Main Menu                                     ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set /p otherinput=.%BS%

if /I "%otherinput%"=="1" (
    shutdown /s /t 0
) else if /I "%otherinput%"=="2" (
    shutdown /r /t 0
) else if /I "%otherinput%"=="3" (
    call :check_internet
    pause
) else if /I "%otherinput%"=="4" (
    goto menu
) else (
    echo [!] Invalid option. Please try again.
    timeout /t 2 >nul
)

goto other_options

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

:check_internet
echo.
echo Checking internet connection...
ping www.google.com -n 1 >nul 2>&1
if %errorlevel%==0 (
    echo [OK] You are connected to the internet.
) else (
    echo [ERROR] No internet connection.
)
echo.
goto :eof

:check_update
setlocal enabledelayedexpansion
set "GITHUB_API=https://api.github.com/repos/l3andromarqu3s/OpenX/releases/latest"

echo Checking for updates...

for /f "usebackq tokens=*" %%A in (`curl -s %GITHUB_API% ^| findstr /i "tag_name"`) do (
    set "line=%%A"
)

echo Response line: !line!

for /f "tokens=2 delims=:," %%V in ("!line!") do set "LATEST_VERSION=%%~V"
set "LATEST_VERSION=!LATEST_VERSION:"=!"
set "LATEST_VERSION=!LATEST_VERSION: =!"

if /i "!LATEST_VERSION:~0,1!"=="v" set "LATEST_VERSION=!LATEST_VERSION:~1!"

echo Latest version detected: !LATEST_VERSION!
echo Current version: %CURRENT_VERSION%

call :version_greater "!LATEST_VERSION!" "%CURRENT_VERSION%"
if !errorlevel! == 1 (
    echo.
    echo *** A new version is available on GitHub, go check it out! ***
    echo.
) else (
    echo No new version found.
)
endlocal
goto :eof

:version_greater
:: Compares two version strings (v1 and v2)
:: Returns errorlevel 1 if v1 > v2, else 0
:: Usage: call :version_greater "1.2.0" "1.1.0"
setlocal
set "ver1=%~1"
set "ver2=%~2"

:: Split versions by dots
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

:: Fill missing parts with 0
if "%v1_2%"=="" set "v1_2=0"
if "%v1_3%"=="" set "v1_3=0"
if "%v2_2%"=="" set "v2_2=0"
if "%v2_3%"=="" set "v2_3=0"

:: Compare major
if %v1_1% GTR %v2_1% (exit /b 1) else if %v1_1% LSS %v2_1% (exit /b 0)
:: Compare minor
if %v1_2% GTR %v2_2% (exit /b 1) else if %v1_2% LSS %v2_2% (exit /b 0)
:: Compare patch
if %v1_3% GTR %v2_3% (exit /b 1) else (exit /b 0)
