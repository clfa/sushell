<#
    实现功能：打开保存文件对话框，填写文件名，自动生成脚本文件。
	Email：safesky@163.com
	Time：2016/05/07
#>

[ System.Reflection.Assembly ]::LoadWithPartialName("System.Windows.Forms") | Out-Null

# 打印调试信息
Function MsgShowInfo( $InfoShow ) {
    $MSG = [ System.Windows.Forms.MessageBox ]
    $MSG::show( $InfoShow )
}

# 获取当前日期时间
Function GetDateTimeNow() {
    return [System.DateTime]::Now
}

# 删除存在的指定文件
Function DelExistFile( $FileName ) {
    if( Test-Path "$FileName" ) {
        Remove-Item "$FileName"
    }
}

# 将指定的文本文件写为UTF8无BOM格式
Function WriteUTF8WithoutBOMFile( $FileName ) {
    if( Test-Path "$FileName" ) {
        $FileContent = Get-Content $FileName
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding( $False )
        [System.IO.File]::WriteAllLines( $FileName, $FileContent, $Utf8NoBomEncoding )
    }
}

# 写*.bat模板文件
Function WriteBatFile( $FileName ) {
    # MsgShowInfo( $FileName )

    $Time = GetDateTimeNow

    DelExistFile( $FileName )
    
    $fobj = New-Object System.IO.FileInfo "$FileName"
    $strm = $fobj.CreateText()
    
    $strm.WriteLine( "REM Author: safesky" )
    $strm.WriteLine( "REM Time: $Time" )
    $strm.WriteLine( "" )
    $strm.WriteLine( "@echo off" )
    $strm.WriteLine( "" )
    $strm.WriteLine( "cls" )
    $strm.WriteLine( "setlocal enabledelayedexpansion" )
    $strm.WriteLine( "" )
    $strm.WriteLine( "endlocal" )
    $strm.WriteLine( "" )
    $strm.WriteLine( "pause" )

    $strm.Dispose()

    WriteUTF8WithoutBOMFile( $FileName )
}

# 写*.vbs模板文件
Function WriteVBSFile( $FileName ) {
    # MsgShowInfo( $FileName )

    $Time = GetDateTimeNow

    DelExistFile( $FileName )
    
    $fobj = New-Object System.IO.FileInfo "$FileName"
    $strm = $fobj.CreateText()
    
    $strm.WriteLine( "Option Explicit" )    
    $strm.WriteLine( "" )
    $strm.WriteLine( "' Time: $Time" )
    $strm.WriteLine( "" )
    $strm.WriteLine( "' Globals" )
    $strm.WriteLine( "'" )
    $strm.WriteLine( "Function xxx( arguments )" )
    $strm.WriteLine( "" )
    $strm.WriteLine( "End Function" )

    $strm.Dispose()

    WriteUTF8WithoutBOMFile( $FileName )
}

# 获取要创建的脚本文件信息并创建脚本文件，并用notepad++打开该文件进行编辑
Function Get-FileName($initialDirectory) {
    $SaveDlg = New-Object System.Windows.Forms.SaveFileDialog
    $SaveDlg.initialDirectory = $initialDirectory
    $SaveDlg.filter = "Bat File (*.bat)|*.bat|VBS File (*.vbs)|*.vbs"
    $Ret = $SaveDlg.ShowDialog()
    if( $Ret ) {
        if( $SaveDlg.FileName.Length -gt 0 ) {
			# MsgShowInfo( $SaveDlg.FileName )

            if( $SaveDlg.FileName -like "*.bat" ) {  # 生成.bat文件
                WriteBatFile( $SaveDlg.FileName )
            }
            elseif( $SaveDlg.FileName -like "*.vbs" ) { # 生成.vbs文件
                WriteVBSFile( $SaveDlg.FileName )
            }
			
            # 以新的进程来启动创建的新任务，无需父进程等待
            Start-Process -FilePath notepad++.exe -ArgumentList $SaveDlg.FileName
        }
    }
}

Get-FileName -initialDirectory "c:\winwork\mybat\work"
