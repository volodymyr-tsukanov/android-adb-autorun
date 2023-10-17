@echo off

set help=Modes: [0-help 01-change settings]  [1-first start 10-show devices 11-connect 12-disconnect current 13-disconnect all]  [21-screenshoot 22-screenrecord]  [30-app list 31-open app 32-close app 33-close all 34-install apk 35-delete app]  [40-battery check]  [51-unlock 52-lock 53-home 54-back 55-volume- 56 volume+ 57-mute 58-pause 59-crazy input 60-crazy keyboard]  [8-clear 9-exit]
set t="null"
echo %help%


:sett
set /p "cur_ip=Enter target ip: "
if [%cur_ip%]==[] echo Ip required! && goto sett
set /p "o_app=Enter app to open: "
set /p "c_app=Enter app to close & delete: "
if [%c_app%]==[] echo Skipping... && goto end_sett
set /p "i_app=Enter app path to install: "
set /p "sr_l=screenrecord length in sec: "
:end_sett
if [%sr_l%]==[] set sr_l=30
set "msg=Hello!"
echo Done! && cls && echo %help%


:st
set /p "inp=Enter mode: "
set "r=%RANDOM%"


if %inp%==0 echo %help% && goto st

if %inp%==01 goto sett


if %inp%==1  pause && echo Pairing %cur_ip% && adb devices && adb tcpip 7777 && adb connect %cur_ip%:7777 && goto st

if %inp%==10 adb devices && goto st

if %inp%==11 echo Connecting to %cur_ip% && adb connect %cur_ip%:7777 && goto st

if %inp%==12 echo Disconnecting %cur_ip% && adb disconnect %cur_ip%:7777 && goto st

if %inp%==13 echo Disconnecting all && adb disconnect && goto st


if %inp%==21 echo Taking screenshoot %r%.png on %cur_ip% && adb -s %cur_ip%:7777 shell screencap /sdcard/Android/img_%r%.png && adb -s %cur_ip%:7777 pull /sdcard/Android/img_%r%.png tmp/files/ && adb -s %cur_ip%:7777 shell rm -f /sdcard/Android/img_%r%.png && goto st

if %inp%==22 echo Taking screenrecord %r%.mp4 on %cur_ip% && adb -s %cur_ip%:7777 shell screenrecord --time-limit %sr_l% --bit-rate 2000000 --verbose /sdcard/Android/vid_%r%.mp4 && adb -s %cur_ip%:7777 pull /sdcard/Android/vid_%r%.mp4 tmp/files/ && adb -s %cur_ip%:7777 shell rm -f /sdcard/Android/vid_%r%.mp4 && goto st


if %inp%==30 adb -s %cur_ip%:7777 shell pm list packages && goto st

if %inp%==31 echo Opening %o_app% && adb -s %cur_ip%:7777 shell am start -n %o_app% && goto st

if %inp%==32 echo Closing %c_app% && adb -s %cur_ip%:7777 shell input keyevent 3 && adb -s %cur_ip% shell force-stop %c_app% && adb -s %cur_ip%:7777 shell am kill %c_app% && goto st

if %inp%==33 echo Closing device apps && adb -s %cur_ip%:7777 shell am kill-all && goto st

if %inp%==34 echo Installing %i_app% && adb -s %cur_ip%:7777 install -r %i_app% && goto st

if %inp%==35 echo Deletting %c_app% && adb -s %cur_ip%:7777 uninstall %c_app% && goto st


if %inp%==40 adb -s %cur_ip%:7777 shell dumpsys battery && goto st


if %inp%==51 echo Unlocking device && adb -s %cur_ip%:7777 shell input keyevent 82 && goto st

if %inp%==52 echo Locking device && adb -s %cur_ip%:7777 shell input keyevent 26 && goto st

if %inp%==53 echo Home && adb -s %cur_ip%:7777 shell input keyevent 3 && goto st

if %inp%==54 echo Back && adb -s %cur_ip%:7777 shell input keyevent 4 && goto st

if %inp%==55 echo Volume - && adb -s %cur_ip%:7777 shell input keyevent 25 && goto st

if %inp%==56 echo Volume + && adb -s %cur_ip%:7777 shell input keyevent 24 && goto st

if %inp%==57 echo Mute && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb -s %cur_ip%:7777 shell input keyevent 25 && adb shell -s %cur_ip%:7777 input keyevent 25 && goto st

if %inp%==58 echo Pause && adb -s %cur_ip%:7777 shell input keyevent 85 && goto st

if %inp%==59 echo Crazy input starting... && adb -s %cur_ip%:7777 shell input tap 525 1100 && adb -s %cur_ip%:7777 shell input tap 585 1000 && adb -s %cur_ip%:7777 shell input tap 825 800 && adb -s %cur_ip%:7777 shell input tap 125 1550 && goto st

if %inp%==60 echo Crazy keyboard starting... && set /p "msg=Enter msg: " & adb -s %cur_ip%:7777 shell input text %msg% && goto st


if %inp%==8 cls && echo %help% && goto st

if %inp%==9 exit


pause && goto st