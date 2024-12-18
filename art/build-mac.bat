@echo off
color 0a
cd ..
echo BUILDING GAME
haxelib run lime build mac -release
echo.
echo done.
pause
pwd
explorer.exe export\release\windows\bin