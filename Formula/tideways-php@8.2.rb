# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.15.0"
    checksum = {
        "arm" => "28234d7c8a52cb9656cef3c1717bc759e371333187c016fa37b6a071d040dac7",
        "x86" => "be5d9e794499c25b585c3b4df499c4b57f8e0b5aae79e2e5530ffb14d7d0d4f8",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
