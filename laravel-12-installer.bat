@echo off
setlocal

echo [1/2] Installing laravel...
php composer.phar require laravel/installer
if %ERRORLEVEL% neq 0 (
	echo [ERROR] Installing laravel fail...
	pause
	exit /b 1

)

echo.
pause
endlocal