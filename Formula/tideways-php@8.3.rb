# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.18.6"
    checksum = {
        "arm" => "6168153694a13eee3b388efaab2100de35e8a15c44f331b9fee8cfd1c27d524b",
        "x86" => "a3336b735a3632fa70b4f8112c7cb418ba2319c1f9af5ee2f9f2d409d0b4546f",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
