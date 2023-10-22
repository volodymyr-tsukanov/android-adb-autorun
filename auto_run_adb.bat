@echo off


set "help=Modes: [0-help 0.2-additional help 01-view settings 02-change settings]  [1-first start 2-wireless adb connect(bruteforce) 10-show devices 11-connect 12-disconnect current 13-disconnect all 14-change port 14.2-update new port]  [21-screenshoot 22-screenrecord]  [30-app list 31-open app 32-close app 33-close all 34-install apk 35-delete app]  [40-battery check]  [51-unlock 52-lock 53-home 54-back 55-volume- 56 volume+ 57-mute 58-pause 59-crazy input 59.2-fast crazy input 60-crazy keyboard 61-Android action View]  [8-clear 9-exit 99-full exit]"
echo %help%

set "additional_help=Modes: [000-save 001-load]"


:sett
set /p "t=Load from save?[y/ ]: " && set /p "l_pth=Enter load path: " && goto load
set /p "s_pth=Enter save path: "
set /p "cur_ip=Enter target ip: "
if [%cur_ip%]==[] echo Ip required! && goto sett
set /p "cur_port=Enter target port: "
set /p "new_port=Enter new port: "
if [%new_port%]==[] set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%"
:end_sett
echo Done! && echo %help% && adb devices
goto save


:st
set /p "inp=Enter mode: "
set "r=%RANDOM%" & set "wd=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%" & set "hg=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%" & set "tmp_path=temp.bat"

if %inp%==000 goto save

if %inp%==001 goto load


if %inp%==0 echo %help% && goto st

if %inp%==0.2 echo %additional_help% && goto st

if %inp%==01 set s_pth & set cur_ip & set cur_port & set new_port & goto st

if %inp%==02 goto sett


if %inp%==1  echo Pairing %cur_ip%... && set "title=Pair %r%" && set "command=adb devices && adb tcpip %cur_port% && adb connect %cur_ip%:%cur_port% && pause" && goto new_window

if %inp%==2 echo Wireless pairing %cur_ip% by bruteforce && ipconfig && goto wac

if %inp%==10 adb devices && goto st

if %inp%==11 echo Connecting to %cur_ip%... && if [%cur_port%]==[] (adb connect %cur_ip%) else (adb connect %cur_ip%:%cur_port%) && goto st

if %inp%==12 echo Disconnecting %cur_ip%... && if [%cur_port%]==[] (adb disconnect %cur_ip%) else (adb disconnect %cur_ip%:%cur_port%) && goto st

if %inp%==13 echo Disconnecting all... && adb disconnect && goto st

if %inp%==14 echo Changing %cur_ip%:%cur_port% port to %new_port%... && set /p "t=Enter any letter to confirm new port: " && adb -s %cur_ip% tcpip %new_port% && adb disconnect %cur_ip%:%cur_port% && adb connect %cur_ip%:%new_port% && set "cur_port=%new_port%" && set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%" && goto save

if %inp%==14.2 echo Updating new port... && set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%" && goto st


if %inp%==21 echo Taking screenshot %r%.png on %cur_ip%... && set "title=Taking screenshot %r%" && set "command=echo Process... && adb -s %cur_ip%:%cur_port% shell screencap /sdcard/Android/img_%r%.png && adb -s %cur_ip%:%cur_port% pull /sdcard/Android/img_%r%.png tmp/files/ && adb -s %cur_ip%:%cur_port% shell rm -f /sdcard/Android/img_%r%.png && echo Done! && pause" && goto new_window

if %inp%==22 echo Taking screenrecord %r%.mp4 on %cur_ip%... && set "title=Taking screenrecord %r%" && set "command=set /p sec=Enter record duration in seconds: ;adb -s %cur_ip%:%cur_port% shell screenrecord --time-limit !sec! --bit-rate 2000000 --verbose /sdcard/Android/vid_%r%.mp4 && adb -s %cur_ip%:%cur_port% pull /sdcard/Android/vid_%r%.mp4 tmp/files/ && adb -s %cur_ip%:%cur_port% shell rm -f /sdcard/Android/vid_%r%.mp4;echo Done! && pause && exit" && goto new_cmd


if %inp%==30 adb -s %cur_ip%:%cur_port% shell pm list packages && goto st

if %inp%==31 echo Opening app on %cur_ip%... && set "title=Open app %r%" && set "command=adb -s %cur_ip%:%cur_port% shell pm list packages;set /p app=Enter package name to open: ;adb -s %cur_ip%:%cur_port% shell am start -n !app!;pause && exit" && goto new_cmd

if %inp%==32 echo Closing app on on %cur_ip%... && set "title=Close app %r%" && set "command=adb -s %cur_ip%:%cur_port% shell pm list packages;set /p app=Enter package name to close: ;adb -s %cur_ip%:%cur_port% shell am kill !app!;pause && exit" && goto new_cmd

if %inp%==33 echo Closing device apps on %cur_ip%... && set "title=Close apps %r%" && set "command=adb -s %cur_ip%:%cur_port% shell am kill-all && pause" && goto new_window

if %inp%==34 echo Installing app on %cur_ip%... && set "title=Install app %r%" && set "command=set /p app=Enter path to apk: ;adb -s %cur_ip%:%cur_port% install -r !app!;pause && exit" && goto new_cmd

if %inp%==35 echo Deletting app on %cur_ip%... && set "title=Delete app %r%" && set "command=adb -s %cur_ip%:%cur_port% shell pm list packages;set /p app=Enter package name to delete: ;adb -s %cur_ip%:%cur_port% uninstall !app!;pause && exit" && goto new_cmd


if %inp%==40 adb -s %cur_ip%:%cur_port% shell dumpsys battery && goto st


if %inp%==51 echo Unlocking device... && adb -s %cur_ip%:%cur_port% shell input keyevent 82 && goto st

if %inp%==52 echo Locking device... && adb -s %cur_ip%:%cur_port% shell input keyevent 26 && goto st

if %inp%==53 echo Home && adb -s %cur_ip%:%cur_port% shell input keyevent 3 && goto st

if %inp%==54 echo Back && adb -s %cur_ip%:%cur_port% shell input keyevent 4 && goto st

if %inp%==55 echo Volume - && adb -s %cur_ip%:%cur_port% shell input keyevent 25 && goto st

if %inp%==56 echo Volume + && adb -s %cur_ip%:%cur_port% shell input keyevent 24 && goto st

if %inp%==57 echo Muting %cur_ip%... && set "title=Muting %r%" && set "command=for /l %%n in (0, 1, 16) do adb -s %cur_ip%:%cur_port% shell input keyevent 25" && goto new_window

if %inp%==58 echo Pause && adb -s %cur_ip%:%cur_port% shell input keyevent 85 && goto st

if %inp%==59 echo Crazy input starting on %cur_ip%... && set "title=Crazy input %r%" && set "command=for /l %%n in (50, 25, 800) do adb -s %cur_ip%:%cur_port% shell input tap %%n %%n" && goto new_window

if %inp%==59.2 echo Fast crazy input starting on %cur_ip%... && set "title=Fast crazy input %r%" && set "command=for /l %%n in (50, 25, 800) do start /b ^" ^" adb -s %cur_ip%:%cur_port% shell input tap %%n %%n" && goto new_window

if %inp%==60 echo Crazy keyboard starting on %cur_ip%... && set "title=Crazy keyboard %r%" && set "command=:begin;set /p msg=Enter msg: ;adb -s %cur_ip%:%cur_port% shell input text !msg!;goto begin" && goto new_cmd

if %inp%==61 echo Action view on %cur_ip%... && set "title=Action view %r%" && set "command=set /p vd=Enter link to open: ;adb -s %cur_ip%:%cur_port% shell am start -a android.intent.action.VIEW -d !vd!;pause && exit" && goto new_cmd


if %inp%==8 cls && echo %help% && adb devices && goto st

if %inp%==9 exit

if %inp%==99 adb kill-server && exit


pause && goto st


::methods
:wac
start "Wireless port bruteforce" cmd /c "for /l %%n in (0, 2048, 65536) do telnet %cur_ip% %%n"
echo Wait for bruteforce && pause && goto st

:new_window
start "%title%" cmd /c "%command%"
goto st

:new_cmd
echo @echo off > %tmp_path% && echo setlocal enabledelayedexpansion >> %tmp_path%
for /f "tokens=1-9 delims=;" %%a in ("%command%") do echo %%a >> %tmp_path% && echo %%b >> %tmp_path% && echo %%c >> %tmp_path% && echo %%d >> %tmp_path% && echo %%e >> %tmp_path% && echo %%f >> %tmp_path% && echo %%g >> %tmp_path%
start "%title%" %tmp_path%
goto st

:save
if [%s_pth%]==[] echo Enter save path firstly && goto sett
echo %cur_ip%;%cur_port% > %s_pth% && echo Data saved
goto st

:load
for /f "tokens=1-9 delims=;" %%a in (%l_pth%) do set "cur_ip=%%a" & set "cur_port=%%b"
set "s_pth=%l_pth%"

set "new_port=%RANDOM:~0,1%%RANDOM:~-1%%RANDOM:~-1%%RANDOM:~-1%"
goto end_sett


pause && goto sett