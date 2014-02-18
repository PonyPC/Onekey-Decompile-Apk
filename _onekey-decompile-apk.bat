@echo off
echo ==================================
echo Onekey Decompile Apk
echo v2.0.1-beta 20140218
echo Based on https://code.google.com/p/onekey-decompile-apk/
echo **********************************
echo How to use
echo ------------------------------------
echo 1. Put your apk in this folder
echo 2. Drag the apk on _onekey-decompile-apk.bat
echo 3. Wait for invoking jd-gui, "File"-"Save All Sources"
echo 4. Folder and apk with the same name is what you needed
echo ==================================

set apkFile=%1
set jarFile=%apkFile%.jar
rem change directory to apk folder
cd /d %apkFile%\..
rem delete previous generation
rd /s /q "%apkFile%" >NUL 2>NUL

rem install framework to ensure decompile without errors
echo .........framework........
java -jar "_tools\apktool\apktool.jar" if "_tools\apktool\framework-res.apk"
echo .........apktool..........
java -jar "_tools\apktool\apktool.jar" decode -d -f "%apkFile%"
echo .........dex2jar..........
call _tools\dex2jar\d2j-dex2jar -f "%apkFile%" -o "%jarFile%"
echo .........jd-gui...........
call _tools\jd-gui\jd-gui "%jarFile%"

rem delete the jar
del /q "%jarFile%" >NUL 2>NUL