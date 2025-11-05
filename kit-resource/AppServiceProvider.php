<?php

namespace App\Providers;

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        ### start: phần custom dự án Providers/AppServiceProvider.php ###
        /**
         * Giới hạn string dài trong database tránh lỗi độ dài vượt quá khả năng lưu trữ
         * Luôn ưu tiên tạo cơ sở dữ liệu dạng utf8mb4_unicode_ci
         * Điều này sẽ cần 4 bit để lưu trữ bất ký tự của nhiều ngôn ngữ (như tiếng Việt, tiếng Nhật...)
         * Việc giới hạn này tránh tràn 254 bit tối đa có thể ghi mặc định
         */

        Schema::defaultStringLength(191);

        ### end: phần custom dự án Providers/AppServiceProvider.php ###
    }
}
