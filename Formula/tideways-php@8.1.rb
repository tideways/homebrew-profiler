# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
    init
    version "5.21.2"
    checksum = {
        "arm" => "61dbe356199f543695ec506a767b926ef2018e85f36f0cb05cf407b391ca23fd",
        "x86" => "7064946f8274ec2f55aab2a5bafdfe24f5230bfb9b148805ad6c6b454cf5617f",
    }

    arch = Hardware::CPU.arm? ? "arm" : "x86"
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-#{arch}.tar.gz"
    sha256 checksum[arch]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
