pushd "%~dp0"

@echo Off
goto CheckPerms

:CheckPerms 
echo Must be run with Administrator Access, checking current permissions.
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Script is running as Administrator, proceeding with Uninstall
    goto Uninstall
) ELSE (
    echo Script is not running as Administrator, please launch script with Administrative Permissions (Run As Administrator)
    echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\InsufficientPermissions.vbs
    echo WScript.Quit (WshShell.Popup( "Administrator Permissions not detected, please Run as Administrator." ,10 ,"Please try again by right clicking, and selecting Run as Administrator", 0)) >> %tmp%\InsufficientPermissions.vbs
    cscript /nologo %tmp%\InsufficientPermissions.vbs
    del tmp%\InsufficientPermissions.vbs
    goto exit
)

:Confirmation
setlocal
CHOICE /C YN /Timeout 5 /D N /M "Are you sure? (Y/N)"
if %errorlevel% == 1 (
    goto Uninstall
) ELSE (
    goto exitnoaction
)


:Uninstall 
Set DirPath="C:\ProgramData\ClipClear" 
Set StartPath ="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\ClipClear.lnk"
del %DirPath%
del %StartPath%
endlocal
goto exitcompleted

:exitnoaction
cls
echo ###################
echo Uninstall Cancelled
echo ###################
endlocal
timeout 2

:exitcompleted 
cls
echo ##############################
echo .....Uninstall Completed.....
echo ##############################
echo Remember to Unpin from Taskbar
echo ##############################
timeout 2
del "%~dp0" & cmd /c "timeout 2 & del C:\ProgramData\ClipClear" & exit