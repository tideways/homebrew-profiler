# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.18.0"
    checksum = {
        "arm" => "ebe143f8fac688236780cd14238b7431ae13eae0b745bc09d096dc75b1a534f4",
        "x86" => "01063ae840a8ed448e945bc0097ef8bd82db1121a85fe25944b7c0a3b8ae7d5f",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
