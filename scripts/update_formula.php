<?php

set_error_handler(function (int $errno, string $errstr, string $errfile, int $errline) {
    if ($errno === E_DEPRECATED || $errno === E_USER_DEPRECATED) {
        return false;
    }

    throw new \ErrorException($errstr, 0, $errno, $errfile, $errline);
});

$currentVersions = json_decode(file_get_contents("https://app.tideways.io/api/current-versions"), true, flags: JSON_THROW_ON_ERROR);

echo "tideways-php", PHP_EOL;
foreach (['8.0', '8.1', '8.2', '8.3', '8.4', '8.5'] as $phpVersion) {
    echo "- {$phpVersion}", PHP_EOL;
    $phpVersionNoDots = str_replace('.', '', $phpVersion);
    $extensionVersion = $currentVersions['php']['version'] ?? throw new RuntimeException("Current Tideways extension version not found in current versions payload.");
    $hashMacosArm = hash_file('sha256', "https://tideways.s3.amazonaws.com/extension/{$extensionVersion}/tideways-php-{$extensionVersion}-macos-arm.tar.gz") ?: throw new RuntimeException("Failed to determine macOS ARM hash.");
    $hashMacosX86 = hash_file('sha256', "https://tideways.s3.amazonaws.com/extension/{$extensionVersion}/tideways-php-{$extensionVersion}-macos-x86.tar.gz") ?: throw new RuntimeException("Failed to determine macOS x86 hash.");
    $hashLinuxArm64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/extension/{$extensionVersion}/tideways-php-{$extensionVersion}-arm64.tar.gz") ?: throw new RuntimeException("Failed to determine Linux ARM64 hash.");
    $hashLinuxX86_64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/extension/{$extensionVersion}/tideways-php-{$extensionVersion}-x86_64.tar.gz") ?: throw new RuntimeException("Failed to determine Linux x86_64 hash.");

    file_put_contents(
        __DIR__ . "/../Formula/tideways-php@{$phpVersion}.rb",
        <<<FORMULA
            # typed: false
            # frozen_string_literal: true

            require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

            class TidewaysPhpAT{$phpVersionNoDots} < AbstractTidewaysPhpExtension
                init
                version "{$extensionVersion}"
                checksum = {
                    "macos-arm" => "{$hashMacosArm}",
                    "macos-x86" => "{$hashMacosX86}",
                    "arm64" => "{$hashLinuxArm64}",
                    "x86_64" => "{$hashLinuxX86_64}",
                }

                if OS.linux?
                    os = ""
                    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
                else
                    os = "macos-"
                    arch = Hardware::CPU.arm? ? "arm" : "x86"
                end

                url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
                sha256 checksum["#{os}#{arch}"]

                def install
                    prefix.install "tideways-php-#{php_version}.so"
                    write_config_file
                end
            end

            FORMULA,
    );
}

echo "tideways-daemon", PHP_EOL;
$daemonVersion = $currentVersions['daemon']['version'] ?? throw new RuntimeException("Current Tideways extension version not found in current versions payload.");
$hashMacosArm64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/daemon/{$daemonVersion}/tideways-daemon_macos_arm64-{$daemonVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine macOS ARM64 hash.");
$hashMacosAmd64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/daemon/{$daemonVersion}/tideways-daemon_macos_amd64-{$daemonVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine macOS AMD64 hash.");
$hashLinuxAarch64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/daemon/{$daemonVersion}/tideways-daemon_linux_aarch64-{$daemonVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine Linux aarch64 hash.");
$hashLinuxAmd64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/daemon/{$daemonVersion}/tideways-daemon_linux_amd64-{$daemonVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine Linux AMD64 hash.");

file_put_contents(
    __DIR__ . '/../Formula/tideways-daemon.rb',
    <<<FORMULA
        require "formula"

        class TidewaysDaemon < Formula
            homepage 'https://tideways.com'
            version "{$daemonVersion}"
            checksum = {
                "macos-arm64" => "{$hashMacosArm64}",
                "macos-amd64" => "{$hashMacosAmd64}",
                "linux-aarch64" => "{$hashLinuxAarch64}",
                "linux-amd64" => "{$hashLinuxAmd64}",
            }

            if OS.linux?
                os = "linux"
                arch = Hardware::CPU.arm? ? "aarch64" : "amd64"
            else
                os = "macos"
                arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            end

            url "https://tideways.s3.amazonaws.com/daemon/#{version}/tideways-daemon_#{os}_#{arch}-#{version}.tar.gz"
            sha256 checksum["#{os}-#{arch}"]

            def install
                bin.install 'tideways-daemon'
            end

            def post_install
                (var/"log/tideways").mkpath
            end

            service do
                run [opt_bin/"tideways-daemon", "--address", "127.0.0.1:9135", "--env", "development"]
                log_path var/"log/tideways/daemon.log"
            end

            test do
                system opt_bin/"tideways-daemon", "-version"
            end

            def caveats
                <<~EOS

                Please contact support@tideways.com if you have problems setting up the daemon.

                EOS
            end
        end

        FORMULA,
);


echo "tideways-cli", PHP_EOL;
$cliVersion = $currentVersions['cli']['version'] ?? throw new RuntimeException("Current Tideways extension version not found in current versions payload.");
$hashMacosArm64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/cli/{$cliVersion}/tideways-cli_macos_arm64-{$cliVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine macOS ARM64 hash.");
$hashMacosAmd64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/cli/{$cliVersion}/tideways-cli_macos_amd64-{$cliVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine macOS AMD64 hash.");
$hashLinuxArm64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/cli/{$cliVersion}/tideways-cli_linux_arm64-{$cliVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine Linux ARM64 hash.");
$hashLinuxAmd64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/cli/{$cliVersion}/tideways-cli_linux_amd64-{$cliVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine Linux AMD64 hash.");

file_put_contents(
    __DIR__ . '/../Formula/tideways-cli.rb',
    <<<FORMULA
        require "formula"

        class TidewaysCli < Formula
            homepage 'https://tideways.com'
            version "{$cliVersion}"
            checksum = {
                "macos-arm64" => "{$hashMacosArm64}",
                "macos-amd64" => "{$hashMacosAmd64}",
                "linux-arm64" => "{$hashLinuxArm64}",
                "linux-amd64" => "{$hashLinuxAmd64}",
            }

            if OS.linux?
                os = "linux"
                arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            else
                os = "macos"
                arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            end

            url "https://tideways.s3.amazonaws.com/cli/#{version}/tideways-cli_#{os}_#{arch}-#{version}.tar.gz"
            sha256 checksum["#{os}-#{arch}"]

            def install
                bin.install "tideways"
            end

            test do
                system opt_bin/"tideways", "version"
            end

            def caveats
                return <<~EOS
                Follow the instructions on Tideways Profiler website
                to import your application settings:

                https://app.tideways.io/user/cli-import-settings
                EOS
            end
        end

        FORMULA,
);
