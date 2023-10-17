@echo off

set help=Modes: [0-help 01-change settings]  [10-show devices 11-connect 12-disconnect 13-first start]  [21-screenshoot 22-screenrecord]  [30-app list 31-open app 32-close app 33-close all 34-install apk 35-delete app]  [40-battery check 41-show text]  [51-unlock 52-lock 53-home 54-back 55-volume- 56 volume+ 57-mute 58-pause 59-lock party]  [8-clear 9-exit]
set t="null"
echo %help%


:sett
set /p "cur_ip=Enter target ip: "
set /p "o_app=Enter app to open: "
set /p "c_app=Enter app to close & delete: "
set /p "i_app=Enter app path to install: "
set /p "msg=Enter message to send: "
:st
set /p "inp=Enter mode: "
set "r=%RANDOM%"


if %inp%==0 echo %help% && goto st

if %inp%==01 goto sett


if %inp%==10 adb devices && goto st

if %inp%==11 echo Connecting to %cur_ip% && adb connect %cur_ip%:7777 && goto st

if %inp%==12 echo Disconnecting %cur_ip% && adb disconnect %cur_ip% && goto st

if %inp%==13  pause && echo Pairing %cur_ip% && adb devices && adb tcpip 7777 && adb connect %cur_ip%:7777 && echo Connected to %cur_ip% && goto st


if %inp%==21 echo Taking screenshoot %r%.png && adb shell screencap /sdcard/Android/img%r%.png && adb pull /sdcard/Android/img%r%.png tmp/files/ && adb shell rm -f /sdcard/Android/img%r%.png && goto st

if %inp%==22 echo Taking screenrecord %r%.mp4 && adb shell screenrecord --time-limit 15 --verbose /sdcard/Android/vid%r%.mp4 && adb pull /sdcard/Android/vid%r%.mp4 tmp/files/ && adb shell rm -f /sdcard/Android/vid%r%.mp4 && goto st


if %inp%==30 adb shell pm list packages && goto st

if %inp%==31 echo Opening %o_app% && adb shell am start -n %o_app% && goto st

if %inp%==32 echo Closing %c_app% && adb shell input keyevent 3 && adb shell am kill %c_app% && goto st

if %inp%==33 echo Closing device apps && adb shell am kill-all && goto st

if %inp%==34 echo Installing %i_app% && adb install -r %i_app% && goto st

if %inp%==35 echo Deletting %msg% && adb uninstall %c_app% && goto st


if %inp%==40 adb shell dumpsys battery && goto st

if %inp%==41 echo Showing %cur_ip% && adb shell cat %msg% && goto st


if %inp%==51 echo Unlocking device && adb shell input keyevent 82 && goto st

if %inp%==52 echo Locking device && adb shell input keyevent 26 && goto st

if %inp%==53 echo Home && adb shell input keyevent 3 && goto st

if %inp%==54 echo Back && adb shell input keyevent 4 && goto st

if %inp%==55 echo Volume - && adb shell input keyevent 25 && goto st

if %inp%==56 echo Volume + && adb shell input keyevent 24 && goto st

if %inp%==57 echo Mute && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && adb shell input keyevent 25 && goto st

if %inp%==58 echo Pause && adb shell input keyevent 85 && goto st

if %inp%==59 echo Lock Party && adb shell input keyevent 26 && adb shell input keyevent 26 && adb shell input keyevent 26 && adb shell input keyevent 26 && adb shell input keyevent 26 && goto st


if %inp%==8 cls && echo %help% && goto st

if %inp%==9 exit


pause && goto st