@echo off
title OpenX - by L3andro
chcp 65001 >nul
color 3
:start
call :banner
cd programs

:menu
for /f %%A in (' "prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo       (1)- Discord
echo       (2)- Steam
echo       (3)- Voidstrap
echo       (4)- Epic Games Launcher
echo       (5)- Razer Cortex


set /p imput=.%BS%
if /I %imput% EQU 1 start Discord
if /I %imput% EQU 2 start Steam
if /I %imput% EQU 3 start Voidstrap
if /I %imput% EQU 4 start EGLauncher
if /I %imput% EQU 5 start cortex
cls
goto start


:banner
echo.
echo.
echo            ██████╗ ██████╗ ███████╗███╗   ██╗██╗  ██╗
echo           ██╔═══██╗██╔══██╗██╔════╝████╗  ██║╚██╗██╔╝
echo           ██║   ██║██████╔╝█████╗  ██╔██╗ ██║ ╚███╔╝ 
echo           ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║ ██╔██╗ 
echo           ╚██████╔╝██║     ███████╗██║ ╚████║██╔╝ ██╗
echo            ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝ v 1.0.0
