
@echo off
set DVIMRC=%USERPROFILE%\_vimrc

set DVIMFILES=%USERPROFILE%\vimfiles
if exist "%DVIMRC%" (del "%DVIMRC%")
if exist "%DVIMFILES%" (rd "%DVIMFILES%")
mklink /H "%DVIMRC%" "_vimrc"
mklink /J "%DVIMFILES%" "vimfiles"
echo setup finish
pause