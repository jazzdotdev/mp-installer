@ECHO OFF
set current_dir=%cd%
CD %CMDER_ROOT%\usr\local\bin\machu-picchu\
torchbear.exe init.lua %current_dir% %1 %2
CD %current_dir%
