<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Symfony\Component\Process\Process;

class RedisIOCommand extends Command
{
    protected $signature = 'redis:io {action : run|kill|status}';
    protected $description = 'Low-level Redis I/O control: run, kill, or status.';

    public function handle()
    {
        $action = $this->argument('action');
        $redisPath = base_path('redis\\redis-server.exe');
        $configPath = base_path('redis\\redis.windows.conf');

        switch ($action) {
            case 'run':
                $this->runRedis($redisPath, $configPath);
                break;
            case 'kill':
                $this->killRedis();
                break;
            case 'status':
                $this->checkStatus();
                break;
            default:
                $this->error('Usage: php artisan redis:io {run|kill|status}');
        }
    }

    protected function runRedis($redisPath, $configPath)
    {
        if (!file_exists($redisPath)) {
            $this->error("redis-server.exe not found at: $redisPath");
            return;
        }

        $this->info('Launching Redis (background mode)...');

        $process = new Process([
            'powershell',
            '-WindowStyle',
            'Hidden',
            '-Command',
            "Start-Process -FilePath '$redisPath' -ArgumentList '$configPath' -WindowStyle Hidden"
        ]);
        $process->disableOutput();
        $process->run();

        if ($process->isSuccessful()) {
            $this->info('Redis started successfully.');
        } else {
            $this->error('Failed to start Redis: ' . $process->getErrorOutput());
        }
    }

    protected function killRedis()
    {
        $this->info('Killing Redis process...');
        $process = new Process(['taskkill', '/F', '/IM', 'redis-server.exe']);
        $process->run();

        if (str_contains($process->getOutput(), 'SUCCESS')) {
            $this->info('Redis stopped.');
        } else {
            $this->warn('Redis was not running.');
        }
    }

    protected function checkStatus()
    {
        $this->info('Checking Redis process...');
        $process = new Process(['tasklist', '/FI', 'IMAGENAME eq redis-server.exe']);
        $process->run();
        $output = $process->getOutput();

        if (str_contains($output, 'redis-server.exe')) {
            $this->info('Redis is running.');
        } else {
            $this->warn('Redis is not running.');
        }
    }
}
