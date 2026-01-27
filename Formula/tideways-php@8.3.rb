# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.34.0"
    checksum = {
        "macos-arm" => "f2b28cf8fbc60e7bd3680eef82f0e67462f7e6817e52b0d400eacdcccc6c785b",
        "macos-x86" => "7f059987fc6a01eaea58fa63b266185a57c313ce1b8d2d871abb3f75926051b6",
        "arm64" => "172085e378100af18e4f9abd0924ec9a1a90f4c3dd0ccb7a5bc028befae90aaa",
        "x86_64" => "fa65657bc47b680ffdeb3c14f05701c8f53a3493613266f8ad75e945a875ca99",
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
