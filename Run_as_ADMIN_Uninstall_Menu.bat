@echo off
@chcp 65001 > nul
setlocal
:: 強制切換到腳本所在的目錄
cd /d "%~dp0"

:: --- 自動提升權限邏輯 ---
:check_Permissions
    echo Checking for administrator privileges...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto :got_Privileges
    ) else (
        goto :get_Privileges
    )

:get_Privileges
    echo Requesting administrator privileges...
    set "vbs=%temp%\getadmin.vbs"
    echo Set UAC = CreateObject^("Shell.Application"^) > "%vbs%"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    exit /B

:got_Privileges
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
:: -----------------------

echo ========================================================
echo  已取得管理員權限，正在移除右鍵選單...
echo ========================================================
echo.

reg delete "HKEY_CLASSES_ROOT\*\shell\7zCompressAndDelete" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\7zCompressAndDelete" /f > nul 2>&1

echo.
echo 右鍵選單已成功移除！
echo.
pause