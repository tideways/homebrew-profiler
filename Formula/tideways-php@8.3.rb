# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.10.4"
    checksum = {
        "arm" => "e43f32e02bf443cc84bf55aa777cb395a255d63ca72630820fb6f866889e1f68",
        "x86" => "ee80a365f747942ea0a081dcab62764ca4ca66df6bc31d6bb24eb1e4b6da8ee9",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
