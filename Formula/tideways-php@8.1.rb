# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.26.0"
    checksum = {
        "macos-arm" => "f1ffbfeed34f94bd4e87454623dff7af74bb70667aaba8e272c18eb518042017",
        "macos-x86" => "f14f918f33220e011fdcfdea5cea9d92ac7528c3a4815d374cd0d2f5d340fccb",
        "arm64" => "775498c222f76f3c88fdfbc9d8c9030936c65da1ad4aede0d194a9296c5f8deb",
        "x86_64" => "9c93a92d394c2538d7eab8beabe536a5120e0ec53e31eb1772a9ffa1b1e329e3",
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
