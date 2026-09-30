# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
    init
    checksum = {
        "macos-arm" => "0c7297c28f7507ab5f4f24290defe2b19b4748fe6ffd14af9e7df697d2f46953",
        "macos-x86" => "51943792c22cbf33ddfed996e3eac63dd0ae69b7452db425a35b8c3dc6947b80",
        "arm64" => "86d0c30216e64b712c5c28560d6200e2d0e05e815266aa0cd76f5308fd85bdb8",
        "x86_64" => "d5c4fb8be7c7663488d37378ff0870f75383ae35c9d9f48e25eff05eec9d5e19",
    }

    if OS.linux?
        os = ""
        arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    else
        os = "macos-"
        arch = Hardware::CPU.arm? ? "arm" : "x86"
    end

    # macOS x86 (Intel) is pinned to the last release with an Intel build.
    version("#{os}#{arch}" == "macos-x86" ? "5.44.0" : "5.46.4")

    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
    sha256 checksum["#{os}#{arch}"]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
