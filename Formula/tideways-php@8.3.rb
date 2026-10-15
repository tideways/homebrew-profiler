# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    checksum = {
        "macos-arm" => "6dfc094c766054a9491e37a0f3122bd647751dbcd76d8b4f7ea87222f92f5bd4",
        "macos-x86" => "51943792c22cbf33ddfed996e3eac63dd0ae69b7452db425a35b8c3dc6947b80",
        "arm64" => "1eda9970f7388ff03dd5b2b3a84ab5cbf57857d6bfa2a88ce31d5e2249115255",
        "x86_64" => "ee4a7a717a5b4fd54464f1d8d9983da2a7a08236a88c36b2a6b13be36caa529c",
    }

    if OS.linux?
        os = ""
        arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    else
        os = "macos-"
        arch = Hardware::CPU.arm? ? "arm" : "x86"
    end

    # macOS x86 (Intel) is pinned to the last release with an Intel build.
    version("#{os}#{arch}" == "macos-x86" ? "5.44.0" : "5.47.0")

    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
    sha256 checksum["#{os}#{arch}"]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
