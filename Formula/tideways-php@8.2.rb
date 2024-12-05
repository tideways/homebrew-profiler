# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.16.2"
    checksum = {
        "arm" => "22a43482d2c0c7c95505c71a0ecba6f351669185c7290e737f6ec5d98f87e398",
        "x86" => "15a75f754443bf145200716fa2417cf6a603e44bcd750c0a42c331841aacfe0e",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
