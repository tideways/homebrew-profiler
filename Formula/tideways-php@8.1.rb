# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.13.0"
    checksum = {
        "arm" => "ccd5414d72b00912ca9839445145293fb7de07f9f67cc7af12e299ae0772024c",
        "x86" => "cd4d233819af60fef01da759cbd3a7ca9259ec7cbbde45b7c340e12cd8aaa3e6",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
