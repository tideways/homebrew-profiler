<?php

set_error_handler(function (int $errno, string $errstr, string $errfile, int $errline) {
    if (!(error_reporting() & $errno)) {
        return;
    }
    if ($errno === E_DEPRECATED || $errno === E_USER_DEPRECATED) {
        return false;
    }
    throw new \ErrorException($errstr, 0, $errno, $errfile, $errline);
});

$currentVersions = json_decode(file_get_contents("https://app.tideways.io/api/current-versions"), true, flags: JSON_THROW_ON_ERROR);

echo "tideways-php", PHP_EOL;
foreach (['8.0', '8.1', '8.2', '8.3'] as $phpVersion) {
    echo "- {$phpVersion}", PHP_EOL;
    $phpVersionNoDots = str_replace('.', '', $phpVersion);
    $extensionVersion = $currentVersions['php']['version'] ?? throw new RuntimeException("Current Tideways extension version not found in current versions payload.");
    $hashArm = hash_file('sha256', "https://tideways.s3.amazonaws.com/extension/{$extensionVersion}/tideways-php-{$extensionVersion}-macos-arm.tar.gz") ?: throw new RuntimeException("Failed to determine ARM hash.");
    $hashX86 = hash_file('sha256', "https://tideways.s3.amazonaws.com/extension/{$extensionVersion}/tideways-php-{$extensionVersion}-macos-x86.tar.gz") ?: throw new RuntimeException("Failed to determine x86 hash.");

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
                    "arm" => "{$hashArm}",
                    "x86" => "{$hashX86}",
                }

                arch = Hardware::CPU.arm? ? "arm" : "x86"
                url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
                sha256 checksum[arch]

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
$hashArm64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/daemon/{$daemonVersion}/tideways-daemon_macos_arm64-{$daemonVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine ARM64 hash.");
$hashAmd64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/daemon/{$daemonVersion}/tideways-daemon_macos_amd64-{$daemonVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine AMD64 hash.");

file_put_contents(
    __DIR__ . '/../Formula/tideways-daemon.rb',
    <<<FORMULA
        require "formula"

        class TidewaysDaemon < Formula
            homepage 'https://tideways.com'
            version "{$daemonVersion}"
            checksum = {
                "arm64" => "{$hashArm64}",
                "amd64" => "{$hashAmd64}",
            }

            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            url "https://tideways.s3.amazonaws.com/daemon/#{version}/tideways-daemon_macos_#{arch}-#{version}.tar.gz"
            sha256 checksum[arch]

            def install
                bin.install 'tideways-daemon'

                log_dir = var+'log/tideways'
                log_dir.mkpath unless log_dir.exist?
            end

            service do
                run [opt_bin/"tideways-daemon", "--address", "127.0.0.1:9135", "--log", HOMEBREW_PREFIX/"var/log/tideways/daemon.log", "--env", "development"]
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
$hashArm64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/cli/{$cliVersion}/tideways-cli_macos_arm64-{$cliVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine ARM64 hash.");
$hashAmd64 = hash_file('sha256', "https://tideways.s3.amazonaws.com/cli/{$cliVersion}/tideways-cli_macos_amd64-{$cliVersion}.tar.gz") ?: throw new RuntimeException("Failed to determine AMD64 hash.");

file_put_contents(
    __DIR__ . '/../Formula/tideways-cli.rb',
    <<<FORMULA
        require "formula"

        class TidewaysCli < Formula
            homepage 'https://tideways.com'
            version "{$cliVersion}"
            checksum = {
                "arm64" => "{$hashArm64}",
                "amd64" => "{$hashAmd64}",
            }

            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            url "https://tideways.s3.amazonaws.com/cli/#{version}/tideways-cli_macos_#{arch}-#{version}.tar.gz"
            sha256 checksum[arch]

            def install
                bin.install "tideways"
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
