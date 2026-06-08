@echo off
title Modifying GameUserSettings Insurgency
color 0A

:: Dynamic path to the configuration file (Automatically finds your username)
set "FILE_PATH=%LOCALAPPDATA%\Insurgency\Saved\Config\WindowsClient\GameUserSettings.ini"

if not exist "%FILE_PATH%" (
    echo [ERROR] The file cannot be found here: 
    echo %FILE_PATH%
    echo Make sure the game has been launched at least once.
    pause
    exit /b
)

echo [1/3] Removing "Read-only" attribute if present...
attrib -r "%FILE_PATH%"

echo [2/3] Applying your OverrideOptions configuration...
:: Using PowerShell in the background to replace the line cleanly without breaking quotes
powershell -Command "$text = (Get-Content '%FILE_PATH%') -replace '^OverrideOptions=.*', 'OverrideOptions=((\"r.MotionBlur\", (Value=0,bModified=True)),(\"r.ScopeRenderMode\", (Value=0)),(\"r.Dismemberment\", (Value=1,bModified=True)),(\"r.RagdollMaximum\", (Value=4,bModified=True)),(\"r.FoliageInteractionQuality\", (Value=0)),(\"r.AmbientOcclusionLevels\", (Value=0,bModified=True)),(\"r.MaxAnisotropy\", (Value=4)),(\"r.TessellationAdaptivePixelsPerTriangle\", (Value=9999999)),(\"r.SSR.Quality\", (Value=0)),(\"r.Shadow.MaxResolution\", (Value=1024,bModified=True)),(\"r.Shadow.MaxCSMResolution\", (Value=1024,bModified=True)),(\"r.Streaming.PoolSize\", (Value=4000,bModified=True)),(\"r.ViewDistanceScale.FieldOfViewAffectsHLOD\", (Value=1)))'; Set-Content '%FILE_PATH%' -Value $text"

echo [3/3] Locking the file to "Read-only"...
attrib +r "%FILE_PATH%"

echo.
echo Operation completed successfully! Your settings are locked.
pause