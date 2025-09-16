@echo off
title OpenX - by L3andro
chcp 65001 >nul
color 3

if exist programs (
    cd programs
) else (
    echo Pasta "programs" não encontrada.
    pause
    exit
)

:menu
cls
call :banner

for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo       (1)- Discord
echo       (2)- Steam
echo       (3)- Voidstrap
echo       (4)- Epic Games Launcher
echo       (5)- Razer Cortex
echo.

set /p input=.%BS%

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
    echo Invalid option. Please try again.
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
echo            ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝ v 1.0.1
echo.
