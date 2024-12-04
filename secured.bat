@echo off
chcp 65001 >nul
title 🛠️ Installation des Mods Minecraft 1.20.1
color 07

:: Définir la version actuelle
set "version=1.1.0"
set "repoUrl=https://raw.githubusercontent.com/iSweat-exe/Minecraf-Mods-Downloader/master"
set "updateScript=loader-updated.bat"

:: Vérification des mises à jour
echo 🔍 Vérification des mises à jour...
powershell -Command "& {Invoke-WebRequest -Uri '%repoUrl%/version.txt' -OutFile 'latest-version.txt'}" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Impossible de vérifier les mises à jour. Vérifiez votre connexion Internet.
    pause
    goto :continue
)

set /p latestVersion=<latest-version.txt
del latest-version.txt >nul 2>&1

if "%version%"=="%latestVersion%" (
    echo ✅ Vous utilisez déjà la dernière version (%version%).
    goto :continue
)

echo ⚠️ Une nouvelle version (%latestVersion%) est disponible !
echo 🌐 Téléchargement de la mise à jour...

powershell -Command "& {Invoke-WebRequest -Uri '%repoUrl%/loader.bat' -OutFile '%updateScript%'}" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Échec du téléchargement de la mise à jour.
    pause
    goto :continue
)

echo ✅ Mise à jour téléchargée avec succès.
echo 🔄 Redémarrage avec la version mise à jour...

start "" %updateScript%
exit

:continue
echo 🛠️ Continuation avec la version actuelle (%version%)...
echo.
