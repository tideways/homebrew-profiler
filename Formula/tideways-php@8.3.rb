# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.41.0"
    checksum = {
        "macos-arm" => "094f056398bcb4f26dfe7d757e449326743ed782b2ba6a8122ec21d6f4aa5bef",
        "macos-x86" => "1b507f33578fe9e11df45b577a1695354b0f91294221b47abdad9caf466c046d",
        "arm64" => "f8eed3d2ce265848876def43c75668b22d715a10fc377d78674430aee5eabc62",
        "x86_64" => "87fa991fc9864f428e81f71c3c39165cc70eb3907f3129f789d332fbf8092b5f",
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
