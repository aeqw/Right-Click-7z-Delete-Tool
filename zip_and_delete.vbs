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
    MsgBox "���~: �䤣�� 7zr.exe�I", vbCritical, "�ɮ׿�"
    WScript.Quit
End If

sFirstName = objArgs(0)
sArchiveName = objFSO.GetBaseName(sFirstName) & ".7z"
sArchivePath = objFSO.BuildPath(objFSO.GetParentFolderName(sFirstName), sArchiveName)

' --- �i�֤߭ק�j�Χ�í�w���覡�զX���O ---
Dim aParts()
ReDim aParts(4) ' �إߤ@�Ӱ}�C�Ӧs����O���U�ӳ���

aParts(0) = Chr(34) & s7zrPath & Chr(34)
aParts(1) = "a"
aParts(2) = "-t7z"
aParts(3) = "-mx=9"
aParts(4) = Chr(34) & sArchivePath & Chr(34)

' �N�n���Y���ɮ�/��Ƨ��v�@�[�J�}�C
For Each sArg In objArgs
    ReDim Preserve aParts(UBound(aParts) + 1)
    aParts(UBound(aParts)) = Chr(34) & sArg & Chr(34)
Next

' �N�}�C���Ҧ������ΪŮ�s���_�ӡA�����̲׫��O
sCommand = Join(aParts, " ")
' --- �i�קﵲ���j ---

' �������Y
exitCode = objShell.Run(sCommand, 0, True)

' �ˬd���G�çR��
If exitCode = 0 Then
    For Each sArg In objArgs
        If objFSO.FolderExists(sArg) Then
            objFSO.DeleteFolder sArg, True
        ElseIf objFSO.FileExists(sArg) Then
            objFSO.DeleteFile sArg, True
        End If
    Next
Else
    MsgBox "���Y���ѡI�ӷ��ɮױN���|�Q�R���C" & vbCrLf & "7-Zip ��^���~�X: " & exitCode, vbCritical, "���Y���~"
End If