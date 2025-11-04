@echo off
setlocal

echo =====================================
echo   Redis Portable Installer
echo =====================================
echo.

:: Tạo thư mục redis
if not exist redis mkdir redis
cd redis

:: Tự động lấy thư mục hiện tại
set "REDIS_PATH=%~dp0"

echo [1/3] Downloading Redis 3.2.100 ...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/microsoftarchive/redis/releases/download/win-3.2.100/Redis-x64-3.2.100.zip' -OutFile 'Redis-x64-3.2.100.zip'"

echo [2/3] Unzipping Redis ...
powershell -Command "Expand-Archive -Path 'Redis-x64-3.2.100.zip' -DestinationPath '.' -Force"

echo [3/3] Running Redis server ^(redis-server.exe^) ...
:: Xóa service cũ nếu tồn tại
sc stop RedisServer >nul 2>&1
sc delete RedisServer >nul 2>&1

:: Cài service mới trỏ đúng đường dẫn
sc create RedisServer binPath= "\"%REDIS_PATH%redis\redis-server.exe\" \"%REDIS_PATH%redis\redis.windows.conf\"" start= auto
sc description RedisServer "Redis Windows Service"

:: Chạy service
start /min sc start RedisServer

echo.
echo Turning on redis-cli ^(redis-cli.exe^)...
ping -n 3 127.0.0.1 >nul
start redis-cli.exe
ping -n 3 127.0.0.1 >nul
redis-cli ping
ping -n 3 127.0.0.1 >nul
echo Done! Redis - memory cache server installed and ran! Please check it.
pause
