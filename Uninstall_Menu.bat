@echo off
@chcp 65001 > nul

echo 正在從登錄檔中移除右鍵選單...
echo.

reg delete "HKEY_CLASSES_ROOT\*\shell\7zCompressAndDelete" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\7zCompressAndDelete" /f > nul 2>&1

echo.
echo 右鍵選單已成功移除！
pause