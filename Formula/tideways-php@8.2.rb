# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.16.0"
    checksum = {
        "arm" => "fd05afcff322aecdd2a3fd0aa79ad747ebb53682689b3b6f25ef3f1cdd612220",
        "x86" => "bc60b8c102c2169ef8e2cf0b0c9e63ecca781621b928b2ec6837fc09197462b6",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
