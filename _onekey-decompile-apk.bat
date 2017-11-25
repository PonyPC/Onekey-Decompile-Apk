@echo off
echo ----------------------------------
echo Onekey Decompile Apk
echo v2.3.0 20171125
echo Based on https://code.google.com/p/onekey-decompile-apk/
echo ----------------------------------
if "%1" == "" (
	echo How to use
	echo ==================================
	echo 1. Drag your apk on _onekey-decompile-apk.bat
	echo 2. Wait for invoking jd-gui, "File"-"Save All Sources"
	echo 3. Folder and apk with the same name is what you needed
	echo ==================================
	pause
	exit
)

set apkFile=%1
set jarPath=%~dpn1
set jarFile=%jarPath%\%~n1.jar
:: delete previous generation
rd /s /q "%~dpn1" >NUL 2>NUL

if exist "%~dp0_tools\framework\framework-res.zip" (
	echo Please unzip framework-res.zip in %~dp0_tools\framework firstly
	pause
	exit
)
echo .........apktool..........
java -jar "%~dp0_tools\apktool\apktool_2.3.0.jar" d -p "%~dp0_tools\framework" -s "%apkFile%" -o "%jarPath%"
echo .........dex2jar..........
call "%~dp0_tools\dex2jar\d2j-dex2jar.bat" -f "%apkFile%" -o "%jarFile%"
echo .........jd-gui...........
call "%~dp0_tools\jd-gui\jd-gui" "%jarFile%"
echo .........jadx-gui.........
call "%~dp0_tools\jadx\bin\jadx-gui.bat" "%apkFile%"