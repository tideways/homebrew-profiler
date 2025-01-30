# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
    init
    version "5.17.2"
    checksum = {
        "arm" => "4f8dc7c0f281e4b3aa47bc00d46c39793cc811ce649a7fae1998a4d5be9dc01e",
        "x86" => "97ae9825c770f107d95b84c2e6f7465834721c20fdd9ff7da94f8274a3dac4d4",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
