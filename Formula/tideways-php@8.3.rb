# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.19.0"
    checksum = {
        "arm" => "6baddcaffe78eccc7207b8ab56538d52975ea77338d980360ba1fdb066c4008f",
        "x86" => "574b974e019e8461f2e56c1c4670d0a519bdf4c7a11eab0ba6d059afc5998a0a",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
