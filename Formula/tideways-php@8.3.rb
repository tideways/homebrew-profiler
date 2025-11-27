# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.32.0"
    checksum = {
        "macos-arm" => "a21f0caa2f35dd7c3e14d3b363a1f93644995da5a591b36573a395dfafc706c8",
        "macos-x86" => "dd238b76ee5e6bf7f01ab2ac73a70e7ff7b74f31cf05ae3fc3f930e8562d6fad",
        "arm64" => "1d55e67a9ac3bba7df08d26367b039df5f2397bb48063a290f131c9b4ee475dc",
        "x86_64" => "5fc9b1d3ddcf86495823a8765e7f316bd86355fdb7ad17fd3fc098b4c2f3a90f",
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
