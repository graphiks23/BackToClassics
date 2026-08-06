@echo off
setlocal

set "PROCESSED_DIR=D:\media\fla\BackToGlobal\BackToClassics\out"
set "MISSING_COUNT=0"

if not defined PROCESSED_DIR (
    echo Error: No processed directory was supplied.
    pause
    exit /b 1
)

if not exist "%PROCESSED_DIR%\" (
    echo Error: Processed directory not found: "%PROCESSED_DIR%"
    pause
    exit /b 1
)

echo Checking required processed files...
echo Folder: "%PROCESSED_DIR%"
echo.

for %%N in (
    btc_shared_assets.sc
    effects_brawler_grom.sc
    events.sc
    hero_portraits.sc
    brawl_pass.sc
    buddy.sc
    background_basic_remaster.sc
    loading_btc.sc
    daily_wins.sc
    profile.sc
    shop.sc
    ui.sc
    trophy_world_common.sc
) do (
    if not exist "%PROCESSED_DIR%\%%N" (
        echo MISSING: %%N
        set /a MISSING_COUNT+=1
    )
)

echo.
if "%MISSING_COUNT%"=="0" (
    echo All required .sc files are present.
) else (
    echo Missing %MISSING_COUNT% required file^(s^).
)

pause
endlocal
