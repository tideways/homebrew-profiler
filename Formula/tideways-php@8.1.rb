# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.36.0"
    checksum = {
        "macos-arm" => "3c28ff7b5c70c6b89e1c955acc83d07fc76adf5e4d017effe9b99eb648cb7d96",
        "macos-x86" => "c8bd9f759c68bde34e08fc11665e12523dcf05e882d08d4057e110ea44ea9746",
        "arm64" => "1c3dfad9f2ede928e18ecf87731fb13e039955ac5571fccce8fc29b036f9b90e",
        "x86_64" => "04a97a7fff16deb681bb609dbbdc4a96d25d4e653618bf24281cd83c19aea69a",
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
