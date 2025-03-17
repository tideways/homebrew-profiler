# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.20.0"
    checksum = {
        "arm" => "55f817d523582a8151dbdd204684577c3e42a0b8433e42bedfee28d773f59223",
        "x86" => "deb40f719824d6c179322e05a35e676157b8dcc470296891c3152d578337244a",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
