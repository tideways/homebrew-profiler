# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.29.0"
    checksum = {
        "macos-arm" => "6cf0d9a360470c5c4b2f4796124e485bb718f7b6a0c3edaac22dbe42b5cd4dd1",
        "macos-x86" => "85842eceecff216d21b6bda6b95e7e8233409fb292ed59df83dd1896a631d75d",
        "arm64" => "23f346d53170d144fcfa3c35ed8b2e5b63aa7c7201ae05fd79b8a5b639785772",
        "x86_64" => "c68391dc1362e0dd62ff97bb062c769ab9e29ca97385d74a3dc61c936dc09551",
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
