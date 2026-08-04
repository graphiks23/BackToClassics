@echo off
setlocal

set "PROCESSED_DIR=%~1"

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
set /a MISSING_COUNT=0

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
        echo WARNING: Missing "%%N"
        set /a MISSING_COUNT+=1
    )
)

if %MISSING_COUNT% EQU 0 (
    echo All required .sc files are present.
) else (
    echo.
    echo WARNING: %MISSING_COUNT% required file^(s^) are missing.
)

echo.
choice /C YN /N /M "Copy the processed files to their configured destinations? [Y/N]: "
if errorlevel 2 (
    echo Copy cancelled.
    pause
    exit /b 0
)

call :CopyOne "btc_shared_assets.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\sc"
call :CopyOne "effects_brawler_grom.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\sc"
call :CopyOne "events.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\sc"
call :CopyOne "hero_portraits.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\skins\oldPortraits\sc"
call :CopyOne "brawl_pass.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\brawlPass\sc"
call :CopyOne "buddy.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\buddy\sc"
call :CopyOne "background_basic_remaster.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\classicTheme\sc"
call :CopyOne "loading_btc.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\classicTheme\sc"
call :CopyOne "daily_wins.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\dailyWins\sc"
call :CopyOne "profile.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\profile\sc"
call :CopyOne "shop.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\shop\sc"
call :CopyOne "ui.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\ui\sc"
call :CopyOne "trophy_world_common.sc" "C:\Users\graphik\Documents\MuMuSharedFolder\BackToClassics\ddb87231-8a9a-4e4e-9bdf-60bcd04d32cf\swfPatch\twCommon\sc"

echo.
echo Configured files finished copying.
pause
exit /b 0

:CopyOne
set "COPY_NAME=%~1"
set "COPY_DEST=%~2"

if not exist "%PROCESSED_DIR%\%COPY_NAME%" (
    echo SKIPPED: Missing "%COPY_NAME%"
    exit /b 0
)

if not exist "%COPY_DEST%\" mkdir "%COPY_DEST%"
if not exist "%COPY_DEST%\" (
    echo ERROR: Could not create "%COPY_DEST%"
    exit /b 1
)

copy /Y "%PROCESSED_DIR%\%COPY_NAME%" "%COPY_DEST%\%COPY_NAME%" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy "%COPY_NAME%"
) else (
    echo COPIED: "%COPY_NAME%"
)
exit /b 0

endlocal
