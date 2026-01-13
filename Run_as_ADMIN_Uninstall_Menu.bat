@echo off
@chcp 65001 > nul

:: --- 檢查是否有管理員權限 ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ========================================================
    echo  [錯誤] 權限不足！(Permission Denied)
    echo.
    echo  請對此檔案點擊右鍵，選擇「以系統管理員身分執行」。
    echo  Please right-click and select "Run as administrator".
    echo ========================================================
    echo.
    pause
    exit
)
:: ---------------------------

echo 正在從登錄檔中移除右鍵選單...
echo.

reg delete "HKEY_CLASSES_ROOT\*\shell\7zCompressAndDelete" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\7zCompressAndDelete" /f > nul 2>&1

echo.
echo 右鍵選單已成功移除！
pause