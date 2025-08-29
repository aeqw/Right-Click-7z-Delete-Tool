@echo off
@chcp 65001 > nul

echo 正在將「加入壓縮檔(.7z)並刪除」功能登錄到右鍵選單...
echo (採用 All-in-One VBS 模式)
echo.

set VBS_PATH=%~dp0zip_and_delete.vbs

:: --- 直接呼叫萬能的 VBS 腳本 ---
reg add "HKEY_CLASSES_ROOT\*\shell\7zCompressAndDelete" /v "" /t REG_SZ /d "加入壓縮檔(.7z)並刪除" /f
reg add "HKEY_CLASSES_ROOT\*\shell\7zCompressAndDelete\command" /v "" /t REG_SZ /d "wscript.exe \"%VBS_PATH%\" \"%%1\"" /f

reg add "HKEY_CLASSES_ROOT\Directory\shell\7zCompressAndDelete" /v "" /t REG_SZ /d "加入壓縮檔(.7z)並刪除" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\7zCompressAndDelete\command" /v "" /t REG_SZ /d "wscript.exe \"%VBS_PATH%\" \"%%1\"" /f

echo.
echo 右鍵選單已成功加入！
pause