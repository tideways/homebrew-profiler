# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.27.0"
    checksum = {
        "macos-arm" => "b860bbe9e217ec964552e562eed491eb3eb2196c166a51d103f73bbddd3ff572",
        "macos-x86" => "789f388506c2478f8441a797488dfac9a43f2c96f09cf70d4cb968eeec2656b0",
        "arm64" => "029bde45d237e406afe05bb076670dc87c0193202d0884cd67d57cdde869e046",
        "x86_64" => "5bd8bb1928912ae0b288d45122e714e5f7addea92ee64e51ad74ee0004589a16",
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
