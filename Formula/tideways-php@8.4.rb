# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    version "5.28.0"
    checksum = {
        "macos-arm" => "0db44e0c6c2e896c0a86e204f95b7ef70cf476b917583de55b1bc77f04b05296",
        "macos-x86" => "bb27588ac991b3dbce7224e08e6f4e40b6efd32b3c4f01069264aece1ab26fff",
        "arm64" => "b2382973ff8a8cb996849c547b1eeec13299c775dfa7cec3963db3a662f7feaf",
        "x86_64" => "61a5addfbd2a752d044238f6bbfe682c587c567515e527804c17d8dee67c4412",
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
