# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.12.0"
    checksum = {
        "arm" => "fe024a7106c83525985ce90c1b9e98562b45e12a3568c5420487eea8aef60d52",
        "x86" => "0631e8f552cc914f9618b39198f6945a4c03d8dac5aafa378723542d3760a79f",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
