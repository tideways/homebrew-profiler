# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.23.0"
    checksum = {
        "macos-arm" => "a605346d2527a9d6228d760941c247d205883e74be59cd3ebcc05abe6a142694",
        "macos-x86" => "8963bcfebc57db1bc47c29d9bf0ce5ef7ba108f58662bfa21338584991bd992e",
        "arm64" => "0fe80484fed8bb653c0208bb4ec581e0874ee56ac4977268f57da5d3b0bf5b34",
        "x86_64" => "4510db3758273237b1cef450b76d7d0a2152a7a0c3bde5c1f208706a3a70d866",
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
