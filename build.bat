copy lib\SDL3-win32-x64\SDL3.dll SDL3.dll
copy lib\SDL3-win32-x64\SDL3.dll build\win_x64\SDL3.dll

copy lib\SDL3_ttf-win32-x64\SDL3_ttf.dll SDL3_ttf.dll
copy lib\SDL3_ttf-win32-x64\SDL3_ttf.dll build\win_x64\SDL3_ttf.dll

copy "Doto-VariableFont_ROND,wght.ttf" build\win_x64\"Doto-VariableFont_ROND,wght.ttf"
copy Jersey10-Regular.ttf build\win_x64\Jersey10-Regular.ttf

odin build . -o:speed -out:%cd%\build\win_x64\tictactoe.exe