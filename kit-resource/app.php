<?php

use App\Http\Middleware\HandleAppearance;
use App\Http\Middleware\HandleInertiaRequests;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Middleware\AddLinkHeadersForPreloadedAssets;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',

        ### start: phần custom dự án bootstrap/app.php ###
        /**
         * Từ laravel 10+ đã bỏ đi route/api.php (95% không được sử dụng)
         * Nhưng để chuẩn hoá và giảm tải cho route/web.php thì ta kích hoạt ngầm chỉ với dòng code duy nhất được đưa vào đây.
         * Đồng thời tạo thêm api.php ở routes (file chỉ cần <?php ?>, không cần import khởi tạo) 
         */

        api: __DIR__ . '/../routes/api.php',

        ### end: phần custom dự án bootstrap/app.php ###
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->encryptCookies(except: ['appearance', 'sidebar_state']);

        $middleware->web(append: [
            HandleAppearance::class,
            HandleInertiaRequests::class,
            AddLinkHeadersForPreloadedAssets::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
