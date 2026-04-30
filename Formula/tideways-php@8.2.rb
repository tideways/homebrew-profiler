# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
    init
    version "5.39.0"
    checksum = {
        "macos-arm" => "45ba1bcb47f2508387c31f999a4cad7b2d072bf44f1402fcb84af26e3a75c845",
        "macos-x86" => "040c34f0e55faede2c367f263cc07f34113e71d527dcf107cca6b528eacbcf9c",
        "arm64" => "eb4f1bf758ff08004cfe656f5193c683188e8ba37e5bbd6bd4ecfb13af9bd2b0",
        "x86_64" => "980a26bca2fffcff9009923403d7d1ad3617b88b61898bd44cb8f2233963839e",
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
