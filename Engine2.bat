@echo off & mode 65,30
setlocal enabledelayedexpansion
set stat0=0
set maxX=49
set maxY=20
set minX=-1
set minY=-1
set new=False
set alrex=False
set noclip=False
set bdect=False
set InBlock=False
set bdec=False
set I=0
set texCal=False
set "ptr_f=ptr_m"
set "statTxt="
:textures
title textures
set "skin=-"
set "empty= "
set "block=#"
if "%texCal%"=="True" (
set "texCal=False"
goto render
)
:emptylevel
title emptylevel
set "cols=0f"
for /l %%g in (0,1,6%maxX%) do set b%%g=%empty%
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
echo     1 - New Game
echo.
echo     2 - Load Game
echo.
echo     3 - Exit
echo.
choice /c 123>nul
if %errorlevel%==1 (
	cls
	echo.
	echo     Insert map's Name: 
	echo.
	echo.
	set/p mapn=
	if exist engine\maps\!mapn!.bat (
		set alrex=True
		goto menu
	) else (
		set "winPlacePos="
		set "deaPlacePos="
		set "nexLvlPos="
		set new=True
		goto textures
	)
)
if %errorlevel%==2 (
goto loadg
)
if %errorlevel%==3 exit
::
:render
::color 0f
title render -%mapn%
cls
echo  ออออออ BatchGuru - 2D batch game engine ออออออ v0.1
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ%b0%%b1%%b2%%b3%%b4%%b5%%b6%%b7%%b8%%b9%%b10%%b11%%b12%%b13%%b14%%b15%%b16%%b17%%b18%%b19%%b20%%b21%%b22%%b23%%b24%%b25%%b26%%b27%%b28%%b29%%b30%%b31%%b32%%b33%%b34%%b35%%b36%%b37%%b38%%b39%%b40%%b41%%b42%%b43%%b44%%b45%%b46%%b47%%b48%%b49%บ
for /l %%f in (4,4,64) do (
 set pob=%%f
 set /a poc=%%f+1
 set /a pod=%%f+2
 set /a poe=%%f+3
 set /a pof=%%f+4
 ::set /a pog=%%f+5
for /f "tokens=1,2,3,4,5" %%g in ("!pob! !poc! !pod! !poe! !pof!") do echo บ!b%%g0!!b%%g1!!b%%g2!!b%%g3!!b%%g4!!b%%g5!!b%%g6!!b%%g7!!b%%g8!!b%%g9!!b%%h0!!b%%h1!!b%%h2!!b%%h3!!b%%h4!!b%%h5!!b%%h6!!b%%h7!!b%%h8!!b%%h9!!b%%i0!!b%%i1!!b%%i2!!b%%i3!!b%%i4!!b%%i5!!b%%i6!!b%%i7!!b%%i8!!b%%i9!!b%%j0!!b%%j1!!b%%j2!!b%%j3!!b%%j4!!b%%j5!!b%%j6!!b%%j7!!b%%j8!!b%%j9!!b%%k0!!b%%k1!!b%%k2!!b%%k3!!b%%k4!!b%%k5!!b%%k6!!b%%k7!!b%%k8!!b%%k9!บ
)
::                                 4     5     6     7   
::!b%%g0!!b%%g1!!b%%g2!!b%%g3!!b%%g4!!b%%g5!!b%%g6!!b%%g7!!b%%g8!!b%%g9!
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออผ

:controls
title controls -%mapn%
if %stat0%==0 set stat0text=False
if %stat0%==1 set stat0text=True
if %face%==0 set face_text=South
if %face%==1 set face_text=West
if %face%==2 set face_text=North
if %face%==3 set face_text=East
echo X=%loc_x%  Y=%loc_y%  Pos=%ptr_l%  Facing: %face_text%
echo a - Left   d - Right    j - Break Block    p - Save   
echo w - Up     s - Down     k - Place Block    o - NoClip (%noclip%)
echo n - Restart level       l - Turn before moving - %stat0text%
echo m - Back To Menu        e - Exit           x - Stuff
echo r - Reload     ;  State = %statTxt%   ;  New LVL Name(%nexLvlN%)
echo       ptr_m = %ptr_m%      Colors = %cols%
echo   Win Place(%winPlacePos%) Death Place(%deaPlacePos%) Next LVL Place(%nexLvlPos%)
REM echo Bdect = %bdect%     Ptr_i = %ptr_i%      InBlock = %InBlock%
REM echo Bdec = %bdec%
choice /c adwsjknlpomexr >nul
set "statTxt="
::

:lwjgl0
title lwjgl0 -%mapn%
if %errorlevel% GTR 4 goto lwjgl1
set facelast==%face%
if %errorlevel%==1 set face=1
if %errorlevel%==2 set face=3
if %errorlevel%==3 set face=2
if %errorlevel%==4 set face=0
if %stat0%==1 if %facelast% NEQ %face% goto render
set action=move
goto move
:lwjgl1
title lwjgl1 -%mapn%
if %errorlevel%==5 set action=blockbreak
if %errorlevel%==6 set action=blockplace
if %errorlevel%==7 goto emptylevel
if %errorlevel%==8 goto togglemove
if %errorlevel%==9 goto save
if %errorlevel%==10 (
if %noclip%==True set noclip=False
if %noclip%==False set noclip=True
)
if %errorlevel%==11 goto menu
if %errorlevel%==12 goto savExit
if %errorlevel%==13 goto stuff
if %errorlevel%==14 (
set texCal=True
goto :textures
)
goto interact
:togglemove
title togglemove -%mapn%
if %stat0%==0 (
	set stat0=1
	goto render)
	if %stat0%==1 (
	set stat0=0
	goto render)
:interact
title interact -%mapn%
set ptr_last=%ptr_l%
set loc_ym=%loc_y%
set loc_xm=%loc_x%
if %face%==0 set /a loc_ym+=1
if %face%==1 set /a loc_xm-=1
if %face%==2 set /a loc_ym-=1
if %face%==3 set /a loc_xm+=1
if %loc_ym% GTR %maxY% goto render
if %loc_ym% LSS 0 goto render
if %loc_xm% GTR %maxX% goto render
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
title move -%mapn%
set bdect=False
set ptr_last=%ptr_l%
set loc_ym=%loc_y%
set loc_xm=%loc_x%
if %face%==0 set /a loc_ym+=1
if %face%==1 set /a loc_xm-=1
if %face%==2 set /a loc_ym-=1
if %face%==3 set /a loc_xm+=1
set /a ptr_m=%loc_ym%*40+%loc_xm%
set /a ptr_i=%ptr_m%+1
if "!b%ptr_m%!"=="%block%" set bdect=True
if "%noclip%"=="False" (
if not "!b%ptr_m%!"=="%empty%" goto render
)
if %loc_ym% GTR %maxY% goto render
if %loc_ym% LSS 0 goto render
if %loc_xm% GTR %maxX% goto render
if %loc_xm% LSS 0 goto render

:triggers
title TRIGGERS - %mapn%
if "%ptr_m%"=="%winPlacePos%" (
REM call "engine\triggers\"win.bat
set "statTxt=Winning"
)
if "%ptr_m%"=="%deaPlacePos%" (
REM call "engine\triggers\"death.bat
set "statTxt=Dead"
)
if "%ptr_m%"=="%nexLvlPos%" (
set "statTxt=Next LVL..."
::call engine\maps\%nexLvlN%.bat
goto render
)
call "edit\"trig.bat

:legalmove
title legalmove -%mapn%
REM set "statTxt="
set loc_y=%loc_ym%
set loc_x=%loc_xm%
set /a ptr_l=%loc_y%*40+%loc_x%
set b%ptr_l%=%skin%
::
if not "!b%ptr_m%!"=="%block%" (
if not "%bdec%"=="True" (
set b%ptr_last%=%empty%
)
)
if "%bdec%"=="True" (
set "!b%ptr_last%!=%block%"
set bdec=False
set/a I+=1
)
if "%noclip%"=="True" (
if "%bdect%"=="True" (
set b%ptr_l%=%block%
set bdec=True
)
)
goto render
:save
echo set "winPlacePos=%winPlacePos%">"engine\maps\"%mapn%.bat
echo set "deaPlacePos=%deaPlacePos%">>"engine\maps\"%mapn%.bat
echo set "cols=%cols%">>"engine\maps\"%mapn%.bat
echo color %cols%>>"engine\maps\"%mapn%.bat
echo set "lvln=%mapn%">>"engine\maps\"%mapn%.bat
echo set "nexLvlPos=%nexLvlPos%">>"engine\maps\"%mapn%.bat
echo set "nexLvlN=%nexLvlN%">>"engine\maps\"%mapn%.bat
echo set "loc_y=%loc_y%">>"engine\maps\"%mapn%.bat
echo set "loc_x=%loc_x%">>"engine\maps\"%mapn%.bat
echo set "ptr_l=%ptr_l%">>"engine\maps\"%mapn%.bat
REM echo set "b1=!b%%i!">"engine\maps\"!mapn!.bat
for /l %%i in (1,1,6%maxX%) do ( 
if "!b%%i!"=="%skin%" set "b%%i= "
echo set "b%%i=!b%%i!">>"engine\maps\"%mapn%.bat
)
set "b%ptr_l%=%skin%"
goto render
:loadg
cls
echo.
echo     Insert map's Name: 
echo.
echo      Maps : [ 
echo.
dir/b engine\maps\*
echo.
echo  ]
echo.
set/p mapn=
if not exist engine\maps\!mapn!.bat goto menu
call "engine\maps\"%mapn%.bat
set /a ptr_l=%loc_y%*40+%loc_x%
set "b%ptr_l%=%skin%"
goto render
:savExit
title Saving...
echo set "winPlacePos=%winPlacePos%">"engine\maps\"%mapn%.bat
echo set "cols=%cols%">>"engine\maps\"%mapn%.bat
echo color %cols%>>"engine\maps\"%mapn%.bat
echo set "lvln=%mapn%">>"engine\maps\"%mapn%.bat
echo set "deaPlacePos=%deaPlacePos%">>"engine\maps\"%mapn%.bat
echo set "nexLvlPos=%nexLvlPos%">>"engine\maps\"%mapn%.bat
echo set "nexLvlN=%nexLvlN%">>"engine\maps\"%mapn%.bat
echo set "loc_y=%loc_y%">>"engine\maps\"%mapn%.bat
echo set "loc_x=%loc_x%">>"engine\maps\"%mapn%.bat
echo set "ptr_l=%ptr_l%">>"engine\maps\"%mapn%.bat
REM echo set "b1=!b%%i!">"engine\maps\"!mapn!.bat
for /l %%i in (1,1,6%maxX%) do ( 
if "!b%%i!"=="%skin%" set "b%%i= "
echo set "b%%i=!b%%i!">>"engine\maps\"!mapn!.bat
)
exit

:stuff
echo.
echo  1. Win Place    2. Death Place    3. Next Level Place
echo.
echo  4. Colors      5. Back
echo.
echo ______________________________________
echo.
choice /c 12345>nul
if %errorlevel%==1 (
set/P "winPlacePos= Win Place Position: "
)
if %errorlevel%==2 (
set/P "deaPlacePos= Death Place Position: "
)
if %errorlevel%==3 (
set/P "nexLvlPos= Next LVL Place Position: "
set/P "nexLvlN= Next LVL Name: "
)
if %errorlevel%==4 (
set/P "cols= Colors: "


) 
if %errorlevel%==5 (
goto render
)
goto render















