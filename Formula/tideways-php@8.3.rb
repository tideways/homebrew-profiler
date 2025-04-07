# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.21.0"
    checksum = {
        "arm" => "954b16c4ad6bba05539c3f48b412f4f28f7135a67c5d37ace21bae6ad7e8e45a",
        "x86" => "c7830a80a29ecdeb10c020f148c5a28a64a45dcf560425e70238cf3a7e43c7a9",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
