' =====================================================================
' All-in-One 7z Compress and Delete Script (v3.2 - Ultra Stable)
' =====================================================================

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments

If objArgs.Count = 0 Then
    WScript.Quit
End If

sVbsPath = WScript.ScriptFullName
sParentFolder = objFSO.GetParentFolderName(sVbsPath)
s7zrPath = objFSO.BuildPath(sParentFolder, "7zr.exe")

If Not objFSO.FileExists(s7zrPath) Then
    MsgBox "錯誤: 找不到 7zr.exe！", vbCritical, "檔案遺失"
    WScript.Quit
End If

sFirstName = objArgs(0)
sArchiveName = objFSO.GetBaseName(sFirstName) & ".7z"
sArchivePath = objFSO.BuildPath(objFSO.GetParentFolderName(sFirstName), sArchiveName)

' --- 【核心修改】用更穩定的方式組合指令 ---
Dim aParts()
ReDim aParts(4) ' 建立一個陣列來存放指令的各個部分

aParts(0) = Chr(34) & s7zrPath & Chr(34)
aParts(1) = "a"
aParts(2) = "-t7z"
aParts(3) = "-mx=9"
aParts(4) = Chr(34) & sArchivePath & Chr(34)

' 將要壓縮的檔案/資料夾逐一加入陣列
For Each sArg In objArgs
    ReDim Preserve aParts(UBound(aParts) + 1)
    aParts(UBound(aParts)) = Chr(34) & sArg & Chr(34)
Next

' 將陣列的所有部分用空格連接起來，成為最終指令
sCommand = Join(aParts, " ")
' --- 【修改結束】 ---

' 執行壓縮
exitCode = objShell.Run(sCommand, 0, True)

' 檢查結果並刪除
If exitCode = 0 Then
    For Each sArg In objArgs
        If objFSO.FolderExists(sArg) Then
            objFSO.DeleteFolder sArg, True
        ElseIf objFSO.FileExists(sArg) Then
            objFSO.DeleteFile sArg, True
        End If
    Next
Else
    MsgBox "壓縮失敗！來源檔案將不會被刪除。" & vbCrLf & "7-Zip 返回錯誤碼: " & exitCode, vbCritical, "壓縮錯誤"
End If