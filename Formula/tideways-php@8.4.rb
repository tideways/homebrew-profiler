# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    checksum = {
        "macos-arm" => "e41d2c73a4b7b6a86371d5b7a826c538a9edcc76d10044ec3f913413b8929204",
        "macos-x86" => "51943792c22cbf33ddfed996e3eac63dd0ae69b7452db425a35b8c3dc6947b80",
        "arm64" => "3a0d9620e45624e10a68d29f5aafee944dd80af7d307ef03c3885143321f6007",
        "x86_64" => "683771d45e711b12c0f5aa0526f256cf88ebd0f791d2ccb2f361d4f7b6745f22",
    }

    if OS.linux?
        os = ""
        arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    else
        os = "macos-"
        arch = Hardware::CPU.arm? ? "arm" : "x86"
    end

    # macOS x86 (Intel) is pinned to the last release with an Intel build.
    version("#{os}#{arch}" == "macos-x86" ? "5.44.0" : "5.46.0")

    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
    sha256 checksum["#{os}#{arch}"]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
