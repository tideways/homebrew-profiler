# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
    init
    version "5.42.0"
    checksum = {
        "macos-arm" => "8bd0e554e649ceddd8dd8ffb01edd52d9e5e41357dadc7a56ea54058d789e8d6",
        "macos-x86" => "3403353747dfd81aa65223af00beee0e8f1fac1dfc45c46f35d2aa29a3ba3e50",
        "arm64" => "5a2614b9a463137d05c3932f174456d392ca0c20864ad6ba296521d584f650e7",
        "x86_64" => "cc6b77937ba857f31811b6555566a8b3875bb2f7716b5ef2ab16f6596a4ce385",
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
