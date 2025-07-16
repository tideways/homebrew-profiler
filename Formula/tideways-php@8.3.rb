# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
    init
    version "5.25.0"
    checksum = {
        "macos-arm" => "d138e19ca208f3178e31442b312761e5162a014c9477cb30f601c7e8bbf76638",
        "macos-x86" => "9375f12cb82c89aee7bfa040f4cf29b1178b3b32f48e278022e710673d92c6e9",
        "arm64" => "58d1a4a49d17dda99ea5c2aeb748eac19005b7dd2141b104c0b86b97d603c006",
        "x86_64" => "b09c2e52ceb5ec7596db10fd052f5aff6c0a6d262e50c1020d7ffe364235ad80",
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
