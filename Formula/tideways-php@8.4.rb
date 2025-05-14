# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    version "5.22.0"
    checksum = {
        "arm" => "1eb21cd78e41f71c79df508334db1c0f76a384cb203424d14022c30a5e5e485a",
        "x86" => "f691eb8d9ba86c8d4a1e6c07cfb80e3d35f701fa8d83001ea5d6413fc819d6c2",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
