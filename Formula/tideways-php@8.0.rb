# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
    init
    checksum = {
        "macos-arm" => "e94b641c4d4083899543d4c961a3b6c407dd54bf6af34c8cbf6ce0b14ae2c0df",
        "macos-x86" => "51943792c22cbf33ddfed996e3eac63dd0ae69b7452db425a35b8c3dc6947b80",
        "arm64" => "ff4f7fb96cff4c66ce1b4d36e21480a74600cdf9d6a0f9e88d29c326ce9c1c20",
        "x86_64" => "a42d8b73cd4e1428e29cd8dcf7ef354b0d5eca6e071868e8cdadc34454cbc574",
    }

    if OS.linux?
        os = ""
        arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    else
        os = "macos-"
        arch = Hardware::CPU.arm? ? "arm" : "x86"
    end

    # macOS x86 (Intel) is pinned to the last release with an Intel build.
    version("#{os}#{arch}" == "macos-x86" ? "5.44.0" : "5.45.0")

    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
    sha256 checksum["#{os}#{arch}"]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
