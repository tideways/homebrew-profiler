# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.23.0"
    checksum = {
        "arm" => "a605346d2527a9d6228d760941c247d205883e74be59cd3ebcc05abe6a142694",
        "x86" => "8963bcfebc57db1bc47c29d9bf0ce5ef7ba108f58662bfa21338584991bd992e",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
