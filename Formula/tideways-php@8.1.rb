# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.18.4"
    checksum = {
        "arm" => "0afd41d1ef582a2d09268daf37fea20ce0730741f863076d565d4f2c0359f5c2",
        "x86" => "ccbadc2e7428154e29b0430b9054a05bf33519df0f986202e4bfdf31700b0832",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
