@echo off
setlocal

echo =====================================
echo   Command "php artisan redis:io run|kill|status" Artisan Binđer 
echo =====================================
echo.

set "DEST=app\Console\Commands\RedisIOCommand.php"
set "RSC=kit-resource\RedisIOCommand.php"

:: Kiểm tra artisan
if not exist artisan (
    echo Please run in laravel project root folder. I need Artisan to bind this command!
    pause
    exit /b
)

:: Kiểm tra file nguồn
if not exist "%RSC%" (
    echo [ERROR] Folder kit-resource can not found: %RSC%
    echo [TUTOR] Please copy it from laravel-kit to paste to the laravel root folder also ^(like redis-command-builder.bat^)
    pause
    exit /b
)

:: Tạo command trước để Laravel auto register (nếu chưa có)
echo [1/2] Command registering ^(Kernel^)...
if not exist "%DEST%" (
    php artisan make:command RedisIOCommand >nul 2>&1
)

:: Ghi đè file
echo [2/2] Replacing command file by resource: %DEST%...
copy /Y "%RSC%" "%DEST%" >nul

if %errorlevel%==0 (
    echo Replacing successfully: %DEST%
) else (
    echo Replacing fail.
)

echo Done! Command RedisIOCommand created successfully.
echo.
echo You can run:
echo     php artisan redis:io run 
echo     php artisan redis:io kill
echo     php artisan redis:io status
echo.
pause

