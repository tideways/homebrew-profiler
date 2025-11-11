# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.31.0"
    checksum = {
        "macos-arm" => "720b1d6fb14a9cdd533a25eba3bdcc6b237500ddbf6fc2ea4f86d1ebebd0e523",
        "macos-x86" => "86dc4e0710277aa8b8072a0e2e956c0f4a8846e3260a4abc6622e2f6242b25a0",
        "arm64" => "3bf047375b15471b65725bf6f24c213458bcb42adaa76124721bd836e0b8b65f",
        "x86_64" => "d4dfd54835be220a018802b79b82871646ba275e60116eb6b58e734b249965e0",
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
