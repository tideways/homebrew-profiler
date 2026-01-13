# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    version "5.33.0"
    checksum = {
        "macos-arm" => "898d424b3f29bf4e905ec2b3c7d1cf681b7301a9020e72fdfef151e12482e8b4",
        "macos-x86" => "1213b3f4f04d086e485d59c04ca69346978a541d212f335149fc20cc5709d58a",
        "arm64" => "cb714883d6c3ed0def0160f0175db72cb5921ef1c5d2c7b5e03a3c25ec53acdf",
        "x86_64" => "e7871463d1c98e41c42bdf5e5f00f936aa64cebac5a60135964b957e5d2e0c50",
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
