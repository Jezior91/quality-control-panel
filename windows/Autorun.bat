@echo off
:: ╔══════════════════════════════════════════════════════════╗
:: ║  TASKLET AGENT PANEL — Autorun Windows                  ║
:: ║  © 2026 tom | PANEL-WIN-v1.0 | Tajemnica Handlowa       ║
:: ╚══════════════════════════════════════════════════════════╝
title Tasklet Agent Panel — Uruchamianie...
color 0A

echo.
echo  ============================================================
echo   TASKLET AGENT CONTROL PANEL v1.0
echo   c 2026 tom ^| Tajemnica Handlowa
echo  ============================================================
echo.
echo  Uruchamianie panelu...
echo.

:: Sprawdz PowerShell
where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo  [BLAD] PowerShell nie zostal znaleziony!
    echo  Zainstaluj PowerShell 5.0 lub nowszy.
    pause
    exit /b 1
)

:: Uruchom skrypt z tego samego katalogu
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0TaskletPanel.ps1"

if %errorlevel% neq 0 (
    echo.
    echo  [BLAD] Panel nie uruchomil sie prawidlowo.
    echo  Kod bledu: %errorlevel%
    pause
)
