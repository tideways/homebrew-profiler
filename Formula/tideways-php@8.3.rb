# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.11.0"
    checksum = {
        "arm" => "a2f0e74e1f13cfecf460e3e21e3c097c2595a86ef434c9d4ed6f73594909948f",
        "x86" => "8da75808476f0c5813cc7c35598626575c0bf49f3c27a0aeda5568510e8478ec",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
