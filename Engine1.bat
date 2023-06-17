@echo off & mode 65,30 & color 0f
setlocal enabledelayedexpansion
set stat0=0
set new=False
set alrex=False
:textures
title textures
set "skin=I"
set "empty= "
set "block=o"
set "locked=False"
set "gamen="
:emptylevel
set "%ptr_l%=%skin%"
title emptylevel
for /l %%g in (0,1,639) do set b%%g=%empty%
set loc_y=7
set loc_x=19
set /a ptr_l=%loc_y%*40+%loc_x%
set b%ptr_l%=%skin%
set face=3
if %new%==True goto render
::Menu'
:menu
color 0f
title Menu'
cls
echo.
echo     1 - Load Game
echo.
echo     2 - Exit
echo.
choice /c 12>nul

if %errorlevel%==1 (
goto loadg
)
if %errorlevel%==2 exit
::
:render
title Playing "%gamen%".
::set "ptr_l=%skin%"
cls
echo.
echo ษออออออออออออออออออออออออออออออออออออออออป
echo บ%b0%%b1%%b2%%b3%%b4%%b5%%b6%%b7%%b8%%b9%%b10%%b11%%b12%%b13%%b14%%b15%%b16%%b17%%b18%%b19%%b20%%b21%%b22%%b23%%b24%%b25%%b26%%b27%%b28%%b29%%b30%%b31%%b32%%b33%%b34%%b35%%b36%%b37%%b38%%b39%บ
for /l %%f in (4,4,63) do (
 set pob=%%f
 set /a poc=%%f+1
 set /a pod=%%f+2
 set /a poe=%%f+3
for /f "tokens=1,2,3,4" %%g in ("!pob! !poc! !pod! !poe!") do echo บ!b%%g0!!b%%g1!!b%%g2!!b%%g3!!b%%g4!!b%%g5!!b%%g6!!b%%g7!!b%%g8!!b%%g9!!b%%h0!!b%%h1!!b%%h2!!b%%h3!!b%%h4!!b%%h5!!b%%h6!!b%%h7!!b%%h8!!b%%h9!!b%%i0!!b%%i1!!b%%i2!!b%%i3!!b%%i4!!b%%i5!!b%%i6!!b%%i7!!b%%i8!!b%%i9!!b%%j0!!b%%j1!!b%%j2!!b%%j3!!b%%j4!!b%%j5!!b%%j6!!b%%j7!!b%%j8!!b%%j9!บ
)
::                                 4     5     6     7   

echo ศออออออออออออออออออออออออออออออออออออออออผ

:controls
title Playing "%gamen%".
if %face%==0 set face_text=South
if %face%==1 set face_text=West
if %face%==2 set face_text=North
if %face%==3 set face_text=East
echo a - Left   d - Right    p - Save    m - Menu
echo w - Up     s - Down     e - Exit
choice /c adwspem >nul

::

:lwjgl0
title Playing "%gamen%".
if %errorlevel% GTR 4 goto lwjgl1
set facelast==%face%
if %errorlevel%==1 set face=1
if %errorlevel%==2 set face=3
if %errorlevel%==3 set face=2
if %errorlevel%==4 set face=0
set action=move
goto move
:lwjgl1
title Playing "%gamen%".
if %errorlevel%==5 goto save
if %errorlevel%==6 goto savExit
if %errorlevel%==7 goto menu
goto interact
:togglemove
if %stat0%==0 (
	set stat0=1
	goto render)
	if %stat0%==1 (
	set stat0=0
	goto render)
:interact
set ptr_last=%ptr_l%
set loc_ym=%loc_y%
set loc_xm=%loc_x%
if %face%==0 set /a loc_ym+=1
if %face%==1 set /a loc_xm-=1
if %face%==2 set /a loc_ym-=1
if %face%==3 set /a loc_xm+=1
if %loc_ym% GTR 15 goto render
if %loc_ym% LSS 0 goto render
if %loc_xm% GTR 39 goto render
if %loc_xm% LSS 0 goto render
set /a ptr_m=%loc_ym%*40+%loc_xm%
if %action%==blockbreak set b%ptr_m%=%empty%
if %action%==blockplace set b%ptr_m%=%block%
goto render
set loc_ym=%loc_y%
set loc_xm=%loc_x%
set /a ptr_l=%loc_y%*40+%loc_x%
if %face%==0 set /a loc_y-=1
if %face%==1 set /a loc_x+=1
if %face%==2 set /a loc_y+=1
if %face%==3 set /a loc_x-=1
pause
echo off
goto render
:move
set ptr_last=%ptr_l%
set loc_ym=%loc_y%
set loc_xm=%loc_x%
if %face%==0 set /a loc_ym+=1
if %face%==1 set /a loc_xm-=1
if %face%==2 set /a loc_ym-=1
if %face%==3 set /a loc_xm+=1
set /a ptr_m=%loc_ym%*40+%loc_xm%

if not "!b%ptr_m%!"=="%empty%" goto render
if %loc_ym% GTR 15 goto render
if %loc_ym% LSS 0 goto render
if %loc_xm% GTR 39 goto render
if %loc_xm% LSS 0 goto render
:triggers
if "%ptr_m%"=="%winPlacePos%" (
call "engine\triggers\"win.bat
goto menu
)
if "%ptr_m%"=="%deaPlacePos%" (
call "engine\triggers\"death.bat
goto menu
)
if "%ptr_m%"=="%nexLvlPos%" (
call games\%gamen%\%nexLvlN%.bat
goto render
)
call "edit\"trig.bat
::call engine\triggers\trigCheck.bat
:legalmove
set loc_y=%loc_ym%
set loc_x=%loc_xm%
set /a ptr_l=%loc_y%*40+%loc_x%
set b%ptr_l%=%skin%
set b%ptr_last%=%empty%
goto render
:save

echo set "winPlacePos=%winPlacePos%">"games\%gamen%\"%lvln%.bat
echo set "deaPlacePos=%deaPlacePos%">>"games\%gamen%\"%lvln%.bat
echo set "nexLvlPos=%nexLvlPos%">>"games\%gamen%\"%lvln%.bat
echo set "nexLvlN=%nexLvlN%">>"games\%gamen%\"%lvln%.bat
echo set "cols=%cols%">>"games\%gamen%\"%lvln%.bat
title Saving...

echo set "loc_y=%loc_y%">>"games\%gamen%\"%lvln%.bat
echo set "loc_x=%loc_x%">>"games\%gamen%\"%lvln%.bat
echo set "ptr_l=%ptr_l%">>"games\%gamen%\"%lvln%.bat

echo color %cols%>>"games\%gamen%\"%lvln%.bat
echo set "lvln=%lvln%">>"games\%gamen%\"%lvln%.bat
for /l %%i in (1,1,639) do ( 
if "!b%%i!"=="%skin%" set "b%%i= "
echo set "b%%i=!b%%i!">>"games\%gamen%\"%lvln%.bat
)
goto render
:savExit
title Saving...

echo set "winPlacePos=%winPlacePos%">"games\%gamen%\"%lvln%.bat
echo set "deaPlacePos=%deaPlacePos%">>"games\%gamen%\"%lvln%.bat
echo set "nexLvlPos=%nexLvlPos%">>"games\%gamen%\"%lvln%.bat
echo set "nexLvlN=%nexLvlN%">>"games\%gamen%\"%lvln%.bat
echo set "cols=%cols%">>"games\%gamen%\"%lvln%.bat

echo set "loc_y=%loc_y%">"games\%gamen%\"%lvln%.bat
echo set "loc_x=%loc_x%">>"games\%gamen%\"%lvln%.bat
echo set "ptr_l=%ptr_l%">>"games\%gamen%\"%lvln%.bat

echo color %cols%>>"games\%gamen%\"%lvln%.bat
echo set "lvln=%lvln%">>"games\%gamen%\"%lvln%.bat
for /l %%i in (1,1,639) do ( 
if "!b%%i!"=="%skin%" set "b%%i= "
echo set "b%%i=!b%%i!">>"games\%gamen%\"%lvln%.bat
)
exit
:loadg
cls
echo.
echo     Insert game's Name: 
if %locked%==True echo ["%gamen%" is locked]
set locked=False
echo.
echo  Games:
echo.
dir/b games\*
echo.
echo.
set/p gamen=
if not exist games\%gamen% (
goto menu
) else (
call "games\%gamen%\"ini.bat
)
:loadg2
if %locked%==True goto loadg
call !gpat!
set "b!ptr_l!=%skin%"
goto render






