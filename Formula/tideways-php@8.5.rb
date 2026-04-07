# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT85 < AbstractTidewaysPhpExtension
    init
    version "5.37.0"
    checksum = {
        "macos-arm" => "e4acd49d18825c66fbf6fb67a1f1cd5b0398bfacf81544af40cbeb92cdc186cc",
        "macos-x86" => "3420bb818195a4c5f82dd64c8499fbbad686eaa52c161ea3d7b5b9e8152a9915",
        "arm64" => "c5e92d2c3b9c0962839f6c9b8a730d362da4f08e9d10cf49edbc0cfa41f277f3",
        "x86_64" => "698df2841052fa7894fbfec2f190444c07e01feccfc8edf19bf752a8f0c20d86",
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
