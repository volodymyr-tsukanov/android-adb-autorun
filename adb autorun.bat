@echo off


set /a "_num=1"


:choice
set /p "inp=1-open new window 0-exit "

if %inp%==0 exit
if %inp%==1 goto st

pause && goto choice


:st
echo Starting Android ADB %_num%...
start "Android ADB %_num%" cmd /c "call auto_run_adb.bat"
echo Android ADB %_num% started...
set /a "_num=_num+1"

pause && goto choice