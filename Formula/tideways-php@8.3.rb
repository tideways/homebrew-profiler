# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.24.0"
    checksum = {
        "macos-arm" => "a74ab6717dc6ff010b37a209fc27077a591f218c52b734f3434aa24328bf96d2",
        "macos-x86" => "0972564711f0a28a5f9cd60a81bac0f7f483b85aee6e081fa992bbfeb09fa180",
        "arm64" => "a67c743c4e1ca4b471263d52ef22a7ebee739530419a7b0366d34a413d1aa454",
        "x86_64" => "1c38da6058211ecd3c2e5bb17e7fed36ce24ea1e050f147db2d7f838becf7a33",
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
