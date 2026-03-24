copy lib\SDL3-win32-x64\SDL3.dll SDL3.dll
copy lib\SDL3-win32-x64\SDL3.dll build\win_x64\SDL3.dll

copy lib\SDL3_ttf-win32-x64\SDL3_ttf.dll SDL3_ttf.dll
copy lib\SDL3_ttf-win32-x64\SDL3_ttf.dll build\win_x64\SDL3_ttf.dll

odin build . -o:speed -target:windows_amd64 -out:%cd%\build\win_x64\tictactoe.exe

copy lib\SDL3-win32-x86\SDL3.dll SDL3.dll
copy lib\SDL3-win32-x86\SDL3.dll build\win_x86\SDL3.dll

copy lib\SDL3_ttf-win32-x86\SDL3_ttf.dll SDL3_ttf.dll
copy lib\SDL3_ttf-win32-x86\SDL3_ttf.dll build\win_x86\SDL3_ttf.dll

D:\odin_x86\odin.exe build . -o:speed -target:windows_i386 -out:%cd%\build\win_x86\tictactoe.exe

del SDL3.dll
del SDL3_ttf.dll