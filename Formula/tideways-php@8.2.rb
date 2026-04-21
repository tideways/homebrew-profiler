# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.38.0"
    checksum = {
        "macos-arm" => "371553e7b1270e652d7b926a492ce2e0b3df7a3778391437754ab16b252c0817",
        "macos-x86" => "f883de0dc0286193d4e4a6ba2452d625b27be49907889a4b3229aa965bbb095f",
        "arm64" => "a761cfd06c4bcdedb0b647ee2f542f686209a9589fe264273d4fd5d223a6b7c1",
        "x86_64" => "3abe02e6b7577320769f24572aff224de9a039fd8e1da2f9b32df94762864e07",
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
