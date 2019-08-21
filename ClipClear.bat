:: Clear Clipboard

echo off | Clip

:: It's that easy...

@echo off


:: Popup notification after clearing
:: to remove the popup, add two colons before lines 12, 13, 14 and 15.
echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\ClearClipSuccess.vbs
echo WScript.Quit (WshShell.Popup( "Clipboard has been cleaned." ,1 ,"Clipboard Cleared!", 0)) >> %tmp%\ClearClipSuccess.vbs
cscript /nologo %tmp%\ClearClipSuccess.vbs
del tmp%\ClearClipSuccess.vbs