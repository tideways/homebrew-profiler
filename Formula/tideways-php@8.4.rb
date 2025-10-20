# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    version "5.30.0"
    checksum = {
        "macos-arm" => "f75e36d5e652f0c5c39d5f7c921b9fe021db2c0a7cc06beac82afe31c401c516",
        "macos-x86" => "de3b8257059cad8aab24f5ec9cbfbef0b24809e15d8b5593f9e8790064776351",
        "arm64" => "65ee9d4c82e89ee90142f5706f0906ee8489e92256ee077219256532d0681e8d",
        "x86_64" => "75f5a5fe60bd27384168126a5b66ea2ab684f255661767924d548d9442fc02e5",
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
