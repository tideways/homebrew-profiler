# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
    init
    version "5.35.0"
    checksum = {
        "macos-arm" => "e043e661c1a630a2dad243ae6111a9f58105633f574202c02b32bdf36efbb168",
        "macos-x86" => "09d7f69d480ee8e39fd7974465e0a2352efd4fc61a37887396ce9f2c1064ff5a",
        "arm64" => "f91aaa453c89e83df1355a8336616046b8b77dcaaad0637e140a9cef610fce43",
        "x86_64" => "1c111d1bcec00ecb8f678c4a5fc9d90c44dde8f2920c429ca09956e25b67ae29",
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
