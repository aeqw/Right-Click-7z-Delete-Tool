' =====================================================================
' FINAL PRODUCTION VERSION - v8.0 (Truly Robust Recursive Deletion)
' - Implemented a recursive subroutine to delete folders with subfolders.
' =====================================================================

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objArgs = WScript.Arguments

If objArgs.Count = 0 Then WScript.Quit

sVbsPath = WScript.ScriptFullName
sParentFolder = objFSO.GetParentFolderName(sVbsPath)
s7zrPath = objFSO.BuildPath(sParentFolder, "7zr.exe")

If Not objFSO.FileExists(s7zrPath) Then
    MsgBox "ERROR: 7zr.exe not found!", vbCritical, "File Not Found"
    WScript.Quit
End If

sFirstName = objArgs(0)
sArchiveName = objFSO.GetBaseName(sFirstName) & ".7z"
sArchivePath = objFSO.BuildPath(objFSO.GetParentFolderName(sFirstName), sArchiveName)

Dim aParts()
ReDim aParts(4) 
aParts(0) = Chr(34) & s7zrPath & Chr(34)
aParts(1) = "a"
aParts(2) = "-t7z"
aParts(3) = "-mx=9"
aParts(4) = Chr(34) & sArchivePath & Chr(34)

For Each sArg In objArgs
    ReDim Preserve aParts(UBound(aParts) + 1)
    aParts(UBound(aParts)) = Chr(34) & sArg & Chr(34)
Next

sCommand = Join(aParts, " ")

exitCode = objShell.Run(sCommand, 0, True)

If exitCode = 0 Then
    On Error Resume Next
    For Each sArg In objArgs
        If objFSO.FolderExists(sArg) Then
            ' --- 【核心修改】呼叫全新的遞迴刪除副程式 ---
            RobustDeleteFolder(sArg)
        ElseIf objFSO.FileExists(sArg) Then
            Set objFile = objFSO.GetFile(sArg)
            objFile.Attributes = 0 ' Reset attributes to Normal
            objFSO.DeleteFile sArg, True
        End If
    Next
    On Error GoTo 0
Else
    MsgBox "Compression Failed! Original files were NOT deleted." & vbCrLf & "7-Zip returned error code: " & exitCode, vbCritical, "Compression Error"
End If

' WScript.Quit ' You can uncomment this if you don't need the subroutine below in memory

' =====================================================================
' Subroutine: RobustDeleteFolder
' Purpose: Deletes a folder and all its contents, including subfolders
'          and files with special attributes (System, Read-only, etc.).
' =====================================================================
Sub RobustDeleteFolder(sFolderPath)
    On Error Resume Next
    Dim objCurrentFolder, objItem
    
    Set objCurrentFolder = objFSO.GetFolder(sFolderPath)
    
    ' Delete all files inside the current folder
    For Each objItem In objCurrentFolder.Files
        objItem.Attributes = 0
        objFSO.DeleteFile objItem.Path, True
    Next
    
    ' Recursively call this subroutine for each subfolder
    For Each objItem In objCurrentFolder.SubFolders
        RobustDeleteFolder(objItem.Path)
    Next
    
    ' Finally, delete the now-empty folder itself
    objFSO.DeleteFolder sFolderPath, True
    
    On Error GoTo 0
End Sub