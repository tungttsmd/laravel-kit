@echo off
setlocal

title Laravel 12 Local Creator (using local composer.phar)
color 0a

echo =====================================
echo   Laravel 12 Project Creator (local)
echo =====================================
echo.

:: Kiểm tra file composer.phar
if not exist "composer.phar" (
    echo [ERROR] composer.phar not found in current folder!
    echo.
    echo Please run "composer-phar-installer.bat" first.
    echo.
    echo  Remember: Temporarily disable antivirus 
    echo  ^(it may block composer install connections^).
    echo.
    pause
    exit /b 1
)


:: Kiểm tra PHP
where php >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] PHP not found in PATH!
    echo Please install PHP or add php.exe to environment PATH.
    pause
    exit /b 1
)
:: Hỏi tên project
set /p PROJECT=Laravel project name (default: my-laravel-project): 
if "%PROJECT%"=="" set PROJECT=my-laravel-project

:: Chạy lệnh lấy vendor laravel trước từ composer.phar
echo [1/2] Using composer.phar to install resources (vendors) for creating laravel project first...
php composer.phar require laravel/installer
if %ERRORLEVEL% neq 0 (
	echo [ERROR] Getting resources fail...
	echo [Syntax fail] php composer.phar require laravel/installer
	pause
	exit /b 1

)

:: Tạo project laravel
echo [2/2] Creating laravel project: %PROJECT% ...
php vendor/bin/laravel new "%PROJECT%" --without=boost
if not exist "%PROJECT%\artisan" (
    echo [ERROR] Failed to create Laravel project or artisan file missing.
    pause
    exit /b 1
)

echo.
echo Done! Laravel project "%PROJECT%" created successfully.
echo Location: %CD%\%PROJECT%
echo.
pause
endlocal