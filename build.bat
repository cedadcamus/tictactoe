copy lib\SDL3-win32-x64\SDL3.dll SDL3.dll
copy lib\SDL3-win32-x64\SDL3.dll build\win_x64\SDL3.dll

copy "Doto-VariableFont_ROND,wght.ttf" build\win_x64\"Doto-VariableFont_ROND,wght.ttf"
copy Jersey10-Regular.ttf build\win_x64\Jersey10-Regular.ttf

odin build . -o:speed -out:%cd%\build\win_x64\tictactoe.exe

butler push build\win_x64 cedad-camus/tic-tac-toe:windows-x64

del SDL3.dll
del SDL3_ttf.dll