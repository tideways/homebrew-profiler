# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT84 < AbstractTidewaysPhpExtension
    init
    checksum = {
        "macos-arm" => "6ab828fca1f73ac8ed5094bf70c2e5ae803a2dbc5dbcea1e4e59e556d5a95a49",
        "macos-x86" => "51943792c22cbf33ddfed996e3eac63dd0ae69b7452db425a35b8c3dc6947b80",
        "arm64" => "dce445a884e6267d3dba9e31d3284d42b1e6fec08156920817883d95f580edbb",
        "x86_64" => "0a209abd670f698ded61395fd6759a93caf83b37b93b0d4a1c5bc67318d6fa52",
    }

    if OS.linux?
        os = ""
        arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    else
        os = "macos-"
        arch = Hardware::CPU.arm? ? "arm" : "x86"
    end

    # macOS x86 (Intel) is pinned to the last release with an Intel build.
    version("#{os}#{arch}" == "macos-x86" ? "5.44.0" : "5.44.0")

    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-#{os}#{arch}.tar.gz"
    sha256 checksum["#{os}#{arch}"]

    def install
        prefix.install "tideways-php-#{php_version}.so"
        write_config_file
    end
end
