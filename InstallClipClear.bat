@echo Off
goto CheckPerms

:CheckPerms 
echo Must be run with Administrator Access, checking current permissions.
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Script is running as Administrator, proceeding with Install
    goto Install
) ELSE (
    echo Script is not running as Administrator, please launch script with Administrative Permissions (Run As Administrator)
    echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\InsufficientPermissions.vbs
    echo WScript.Quit (WshShell.Popup( "Administrator Permissions not detected, please Run as Administrator." ,10 ,"Please try again by right clicking, and selecting Run as Administrator", 0)) >> %tmp%\InsufficientPermissions.vbs
    cscript /nologo %tmp%\InsufficientPermissions.vbs
    del tmp%\InsufficientPermissions.vbs
    goto exit
)


:Install
pushd "%~dp0"

Set DirPath="C:\ProgramData\ClipClear"

IF not exist %DirPath% {
    mkdir %DirPath%
    goto CopyFiles
} ELSE {
    goto CopyFiles
}

:CopyFiles
:: Copy files to data directory
xcopy .\ClipClear.bat %DirPath% /q /y
xcopy .\ClipClear.ico %DirPath% /q /y
xcopy .\ClipClear.lnk %DirPath% /q /y
xcopy .\LICENSE %DirPath% /q /y
xcopy .\UninstallClipClear.bat %DirPath% /q /y
xcopy .\UninstallClipClear.ico %DirPath% /q /y
xcopy .\UninstallClipClear.lnk %DirPath% /q /y 

:: Copy shortcut to Start Menu
xcopy .\ClipClear.lnk "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" /q /y
goto exit

:exit
cls 
echo. 
echo.
echo Install Completed, now just pin the shortcut in your start menu to the task bar!
timeout 5
exit