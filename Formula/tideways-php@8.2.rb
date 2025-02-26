# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.18.2"
    checksum = {
        "arm" => "0669a81d013480bd5d0e14be5a998022412e20e6ff10f2d3e1130c2e491e32fc",
        "x86" => "9d955a44d29638df213262589bc4a7531cc9ba23e3929aba3fd15552bb0742ff",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
