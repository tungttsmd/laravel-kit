# Hướng dẫn laravel-kit

**_ Cập nhật: 1.0.1 _**

**_ Đây là file hướng dẫn về những gì xảy ra trong laravel-kit _**

## Tóm lược

- Nếu chỉ muốn tạo composer.phar: chạy ** composer-phar-installer.bat ** sẽ tạo ra file tại chỗ
- Nếu muốn tạo dự án, luôn bắt đầu với
  - composer-phar-installer.bat
  - laravel-12-installer.bat
- Nếu dự án laravel muốn sử dụng redis cache
  - copy thư mục kit-resource vào root folder của dự án laravel
  - copy file redis-installer.bat vào root folder của dự án laravel
  - copy file redis-command-builder.bat vào root folder của dự án laravel
  - chạy redis-installer.bat trước
  - tiếp đến chạy redis-command-builder.bat
  - rồi gõ thử php artisan redis:io status -> ra thông báo redis -> cài redis thành công

## 0. Thư mục kit-resource

- Nơi đây chứa những file source dùng để gắn vào dự án
- Source code cần dùng cho việc tạo tự động các command io cơ bản như:
  > `php artisan redis:io run|kill|status`
- Sau khi sử dụng có thể xoá để gọn gàng source code

## 1. composer-phar-installer.bat

- ** [Yêu cầu] Chạy trước khi tạo dự án laravel **
- Đây là file dành cho dự án laravel mới

## 2. laravel-12-installer.bat

- ** [Yêu cầu] cần composer.phar để tạo dự án **
- Đây là file tạo dự án laravel
- Dự án sẽ gói gọn local, tức là chỉ nằm trong một thư mục

## 3. redis-install.bat

- ** [Yêu cầu] File này cần chạy trong root folder của dự án laravel **
- Đây là file cài đặt Redis cache server dạng portable => phù hợp mục tiêu local hoá dự án
- Sau khi cài xong, nó sẽ tạo 1 thư mục tên là "redis"
- Mọi thứ cần thiết đều nằm trong thư mục "redis", các thao tác command sẽ trỏ vào đây

## 4. redis-command-builder.bat

- ** [Yêu cầu] File này cần chạy trong root folder của dự án laravel **
- ** [Yêu cầu] File này yêu cầu thư mục kit-resource cùng nằm trong root folder của dự án laravel **
- Nó sẽ make:command tự động đăng ký kernel cho lệnh php artisan redis:io ...
- Sau đó từ kit-resource sẽ copy file RedisIOCommand.php thay vào file cùng tên ở
  > `App/Console/Commands/RedisIOCommand.php`
- Sau khi done!, bạn có thể dùng lệnh
  > `php artisan redis:io run|kill|status`
- để điều khiển io redis (tắt/mở)
