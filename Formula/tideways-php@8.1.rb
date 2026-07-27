# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.43.0"
    checksum = {
        "macos-arm" => "b72b2dfbf6adcc8ede085f9083063a25b9c2f19a4957363b05b18bc6fd802e11",
        "macos-x86" => "b9068f0ffc469a875ad91011d0e990aca83e71e63df24c113c749aec92363ba5",
        "arm64" => "bcd5341429c45803a2ffd13cd46b2b6ae51d36a8016cb9fe4fa8f0d1bc2c99a2",
        "x86_64" => "cb078b8cd5cbc100fac4b884d871f75980db68c0d2ab6dae571aa9d4048e1930",
    }

    if OS.linux?
        os = ""
        arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    else
        os = "macos-"
        arch = Hardware::CPU.arm? ? "arm" : "x86"
    end

    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
    sha256 checksum["#{os}#{arch}"]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
