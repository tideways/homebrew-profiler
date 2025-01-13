# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    version "5.17.0"
    checksum = {
        "arm" => "4ad54f0d618ab1e6a09e4122f5d517d9dbeed3eb4837cc715135a6c4a5b59033",
        "x86" => "5e55a0dd13a2abefe30075549adb0d444c6d962805aa120d93a54eb6efa1bd80",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
