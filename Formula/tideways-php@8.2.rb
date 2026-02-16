# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.34.4"
    checksum = {
        "macos-arm" => "31e7a0a5345824340317225f117dc65019b12af9c1f4e223887800e78f0b8fa6",
        "macos-x86" => "920052ba3299cff0fa1ae599058f9db78309f488a288c2e8a759326f58ec2fce",
        "arm64" => "866f23f2bdde2b06b671168dae95a98d06a64c5e8dd9724a94d87d81314a91db",
        "x86_64" => "b8ed22222de27c6295d4e230397f7d07246194b6363697a6cb4187ca1306a3e9",
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
