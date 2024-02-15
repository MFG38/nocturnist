@echo off
set VERNUM=test

echo Building...
cd src
..\tools\7za a -tzip nocturnist_%VERNUM%.pk3 *.* *
move nocturnist_%VERNUM%.pk3 ..\build\nocturnist_%VERNUM%.pk3
goto Done

:Done
pause >nul
