# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    version "5.22.2"
    checksum = {
        "arm" => "276117c1a002c1866481d00c4d67ce7b9b7441b499f559723875c214b77f7170",
        "x86" => "e1efe0684c0c39c547e0e02a9536ada35971cf730755bc99b7dcba4c2182494c",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
