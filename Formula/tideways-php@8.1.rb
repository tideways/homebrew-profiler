# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.40.0"
    checksum = {
        "macos-arm" => "b172922092e641517c3b1692d09713246ee29f8418e1f7c2f7c6faf2f9361f1d",
        "macos-x86" => "792a391ef8a87a57113b5532184737a616707bae28db552c99bfc07e35071a6b",
        "arm64" => "2d31c7ca9196a17cb84c8459ef39b20ca84f929fc1e8ab613ba25d742ff82639",
        "x86_64" => "fbcba76699ae3c972acbd66af3745c64889aa6ac07f26ebc90aba435b3dd3a95",
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
