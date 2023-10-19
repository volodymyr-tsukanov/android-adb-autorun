@echo off

set "help=Modes: [0-help 01-view settings 02-change settings]  [1-first start 10-show devices 11-connect 12-disconnect current 13-disconnect all 14-change port 14.2-update new port]  [21-screenshoot 22-screenrecord]  [30-app list 31-open app 32-close app 33-close all 34-install apk 35-delete app]  [40-battery check]  [51-unlock 52-lock 53-home 54-back 55-volume- 56 volume+ 57-mute 58-pause 59-crazy input 60-crazy keyboard 61-Android action View]  [8-clear 9-exit 99-full exit]"
echo %help%


:sett
set /p "t=Load from save?[y/ ]: " && set /p "l_pth=Enter load path: " && goto load
set /p "s_pth=Enter save path: "
set /p "cur_ip=Enter target ip: "
if [%cur_ip%]==[] echo Ip required! && goto sett
set /p "cur_port=Enter target port: "
if [%cur_port%]==[] set cur_port=7777
set /p "new_port=Enter new port: "
if [%new_port%]==[] set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%"
set /p "o_app=Enter app to open: "
set /p "c_app=Enter app to close & delete: " || echo Skipping... && goto end_sett
set /p "i_app=Enter app path to install: "
set /p "sr_l=screenrecord length in sec: "
if [%sr_l%]==[] set sr_l=30
set /p "vd=Enter link to open: "
if [%vd%]==[] set "vd=http://www.youtube.com/"
set /p "msg=Enter messsage: "
if [%msg%]==[] set "msg=Hello!"
:end_sett
echo Done! && cls && echo %help% && adb devices
goto save


:st
set /p "inp=Enter mode: "
set "r=%RANDOM%"

if %inp%==000 goto save


if %inp%==0 echo %help% && goto st

if %inp%==01 set s_pth & set cur_ip & set cur_port & set new_port & set o_app & set c_app & set i_app & set sr_l & set msg & set vd & goto st

if %inp%==02 goto sett


if %inp%==1  pause && echo Pairing %cur_ip% && adb devices && adb tcpip %cur_port% && adb connect %cur_ip%:%cur_port% && goto st

if %inp%==10 adb devices && goto st

if %inp%==11 echo Connecting to %cur_ip%... && adb connect %cur_ip%:%cur_port% && goto st

if %inp%==12 echo Disconnecting %cur_ip%... && adb disconnect %cur_ip%:%cur_port% && goto st

if %inp%==13 echo Disconnecting all... && adb disconnect && goto st

if %inp%==14 echo Changing %cur_ip%:%cur_port% port to %new_port%... && set /p "t=Enter any letter to confirm new port: " && adb -s %cur_ip% tcpip %new_port% && adb disconnect %cur_ip%:%cur_port% && adb connect %cur_ip%:%new_port% && set "cur_port=%new_port%" && goto save

if %inp%==14.2 echo Updating new port... && set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%" && goto st


if %inp%==21 echo Taking screenshoot %r%.png on %cur_ip%... && adb -s %cur_ip%:%cur_port% shell screencap /sdcard/Android/img_%r%.png && adb -s %cur_ip%:%cur_port% pull /sdcard/Android/img_%r%.png tmp/files/ && adb -s %cur_ip%:%cur_port% shell rm -f /sdcard/Android/img_%r%.png && goto st

if %inp%==22 echo Taking screenrecord %r%.mp4 on %cur_ip%... && adb -s %cur_ip%:%cur_port% shell screenrecord --time-limit %sr_l% --bit-rate 2000000 --verbose /sdcard/Android/vid_%r%.mp4 && adb -s %cur_ip%:%cur_port% pull /sdcard/Android/vid_%r%.mp4 tmp/files/ && adb -s %cur_ip%:%cur_port% shell rm -f /sdcard/Android/vid_%r%.mp4 && goto st


if %inp%==30 adb -s %cur_ip%:%cur_port% shell pm list packages && goto st

if %inp%==31 echo Opening %o_app%... && adb -s %cur_ip%:%cur_port% shell am start -n %o_app% && goto st

if %inp%==32 echo Closing %c_app%... && adb -s %cur_ip%:%cur_port% shell input keyevent 3 && adb -s %cur_ip%:%cur_port% shell am kill %c_app% && goto st

if %inp%==33 echo Closing device apps... && adb -s %cur_ip%:%cur_port% shell am kill-all && goto st

if %inp%==34 echo Installing %i_app%... && adb -s %cur_ip%:%cur_port% install -r %i_app% && goto st

if %inp%==35 echo Deletting %c_app%... && adb -s %cur_ip%:%cur_port% uninstall %c_app% && goto st


if %inp%==40 adb -s %cur_ip%:%cur_port% shell dumpsys battery && goto st


if %inp%==51 echo Unlocking device... && adb -s %cur_ip%:%cur_port% shell input keyevent 82 && goto st

if %inp%==52 echo Locking device... && adb -s %cur_ip%:%cur_port% shell input keyevent 26 && goto st

if %inp%==53 echo Home && adb -s %cur_ip%:%cur_port% shell input keyevent 3 && goto st

if %inp%==54 echo Back && adb -s %cur_ip%:%cur_port% shell input keyevent 4 && goto st

if %inp%==55 echo Volume - && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && goto st

if %inp%==56 echo Volume + && adb -s %cur_ip%:%cur_port% shell input keyevent 24 && goto st

if %inp%==57 echo Mute && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && adb shell -s %cur_ip%:%cur_port% input keyevent 25 && goto st

if %inp%==58 echo Pause && adb -s %cur_ip%:%cur_port% shell input keyevent 85 && goto st

if %inp%==59 echo Crazy input starting... && adb -s %cur_ip%:%cur_port% shell input tap 525 1100 && adb -s %cur_ip%:%cur_port% shell input tap 585 1000 && adb -s %cur_ip%:%cur_port% shell input tap 825 800 && adb -s %cur_ip%:%cur_port% shell input tap 125 1550 && goto st

if %inp%==60 echo Crazy keyboard starting... && set /p "msg=Enter msg: " & adb -s %cur_ip%:%cur_port% shell input text %msg% && goto st

if %inp%==61 echo Action View... && set /p "vd=Enter View data: " && adb -s %cur_ip%:%cur_port% shell am start -a android.intent.action.VIEW -d "%vd%" && goto st


if %inp%==8 cls && echo %help% && adb devices && goto st

if %inp%==9 exit

if %inp%==99 adb kill-server && exit


pause && goto st


:save
if [%s_pth%]==[] echo Enter save path firstly && goto sett
echo %cur_ip%;%cur_port%;%o_app%;%c_app%;%i_app%;%sr_l%;%vd%;%msg% > %s_pth% && echo Data saved
goto st


:load
::ij
for /f "tokens=1-9 delims=;" %%a in (%l_pth%) do set "cur_ip=%%a" & set "cur_port=%%b" & set "o_app=%%c" & set "c_app=%%d" & set "i_app=%%e" & set "sr_l=%%f" & set "vd=%%g" & set "msg=%%h"
set "s_pth=%l_pth%"

set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%"
goto end_sett