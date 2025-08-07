# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.26.2"
    checksum = {
        "macos-arm" => "6ee46d0494c80d6635f03b63c38228efc662ac4a64e94174e043353b7dc0c49e",
        "macos-x86" => "9c428f73dda89cd2f85b0c31b220c5edb994a8e87c902aefc0ad5a5efd45da0d",
        "arm64" => "558c78d9313f95dcaca877df3869f633f23c6a0acf903c2b7cf92bc42e01783e",
        "x86_64" => "657e7e343c8ff1956661f9fb04ec561dd29e5cb476025c28dbb0d9ed0343c398",
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
