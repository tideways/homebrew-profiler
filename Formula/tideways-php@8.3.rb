# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.14.0"
    checksum = {
        "arm" => "aaca474889901d154f8dc4a378044505d36060f0f798ea2a92d034f17f231aa8",
        "x86" => "c9042ec2f1b7f4cfa26ba30628174ae814477e0e4944e917f59cb9cb94886d2c",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
