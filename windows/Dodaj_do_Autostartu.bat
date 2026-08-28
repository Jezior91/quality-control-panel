@echo off
:: ╔══════════════════════════════════════════════════════════╗
:: ║  Dodaj Tasklet Panel do autostartu Windows               ║
:: ║  Uruchom jako Administrator!                             ║
:: ╚══════════════════════════════════════════════════════════╝
title Tasklet Panel — Dodaj do autostartu
color 0B

echo.
echo  ============================================================
echo   TASKLET AGENT PANEL — Dodawanie do Autostartu
echo   c 2026 tom
echo  ============================================================
echo.

:: Sciezka do autostartu
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "TARGET=%~dp0Autorun.bat"
set "SHORTCUT=%STARTUP%\TaskletAgentPanel.bat"

echo  Kopiowanie do: %STARTUP%
copy "%TARGET%" "%SHORTCUT%" >nul 2>&1

if %errorlevel% equ 0 (
    echo.
    echo  [OK] Panel zostal dodany do autostartu!
    echo  Uruchomi sie automatycznie przy nastepnym logowaniu.
) else (
    echo.
    echo  [BLAD] Nie udalo sie dodac do autostartu.
    echo  Sprobuj uruchomic jako Administrator.
)

echo.
echo  Sciezka skrotu: %SHORTCUT%
echo.
pause
