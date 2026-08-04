@echo off
setlocal

set "INPUT_DIR=D:\media\fla\BackToGlobal\BackToClassics\out"
set "OUTPUT_DIR=%INPUT_DIR%\converted"
set "UI_DUM=D:\media\SuperCell assets\brawl-assets\68.250\sc\uiDum.sc"
set "SHOP_DUM=D:\media\SuperCell assets\brawl-assets\68.250\sc\shopDum.sc"
set "BRAWL_PASS_DUM=D:\media\SuperCell assets\brawl-assets\68.250\sc\brawl_passDum.sc"
set "TOOL=SupercellFlashToolCLI.exe"

if not exist "%INPUT_DIR%\" (
    echo Error: Input folder not found: "%INPUT_DIR%"
    exit /b 1
)

if not exist "%OUTPUT_DIR%\" mkdir "%OUTPUT_DIR%"
if not exist "%OUTPUT_DIR%\" (
    echo Error: Could not create output folder: "%OUTPUT_DIR%"
    exit /b 1
)

for %%F in ("%INPUT_DIR%\*.sc") do (
    if exist "%%~fF" (
        echo Converting: "%%~nxF"

        if /I "%%~nxF"=="ui.sc" (
            if not exist "%UI_DUM%" (
                echo Error: Required file not found: "%UI_DUM%"
            ) else (
                "%TOOL%" "%OUTPUT_DIR%\%%~nxF" "%UI_DUM%" "%%~fF" --repack-atlas --repack-banks --texture-type khronos --khronos-compression-type 0x93B5 --override-texture-parameters --remove-unused
                if errorlevel 1 echo Error converting: "%%~nxF"
            )
        ) else if /I "%%~nxF"=="shop.sc" (
            if not exist "%SHOP_DUM%" (
                echo Error: Required file not found: "%SHOP_DUM%"
            ) else (
                "%TOOL%" "%OUTPUT_DIR%\%%~nxF" "%SHOP_DUM%" "%%~fF" --repack-atlas --repack-banks --texture-type khronos --khronos-compression-type 0x93B6 --override-texture-parameters --remove-unused
                if errorlevel 1 echo Error converting: "%%~nxF"
            )
        ) else if /I "%%~nxF"=="brawl_pass.sc" (
            if not exist "%BRAWL_PASS_DUM%" (
                echo Error: Required file not found: "%BRAWL_PASS_DUM%"
            ) else (
                "%TOOL%" "%OUTPUT_DIR%\%%~nxF" "%BRAWL_PASS_DUM%" "%%~fF" --repack-atlas --repack-banks --texture-type khronos --khronos-compression-type 0x93B6 --override-texture-parameters --remove-unused
                if errorlevel 1 echo Error converting: "%%~nxF"
            )
        ) else (
            "%TOOL%" "%OUTPUT_DIR%\%%~nxF" "%%~fF" --repack-atlas --repack-banks --texture-type khronos --khronos-compression-type 0x93B4 --override-texture-parameters --remove-unused
            if errorlevel 1 echo Error converting: "%%~nxF"
        )
    )
)

echo.
if exist "%~dp0post_process.bat" (
    call "%~dp0post_process.bat" "%OUTPUT_DIR%"
) else (
    echo Warning: Auxiliary script not found: "%~dp0post_process.bat"
)

endlocal
