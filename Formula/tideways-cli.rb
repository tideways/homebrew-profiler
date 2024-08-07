require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.1.0"
    checksum = {
        "arm64" => "bc4e2346129bde1b5c5ba4a30fbfb6b1ac8ab9e9af9236bf0eecc277139ad312",
        "amd64" => "a09bc9f06717101892b120fe92dedf27702be5189a98fdce979a1348ca8b68ad",
    }

    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    url "https://tideways.s3.amazonaws.com/cli/#{version}/tideways-cli_macos_#{arch}-#{version}.tar.gz"
    sha256 checksum[arch]

    def install
        bin.install "tideways"
    end

    def caveats
        return <<~EOS
        Follow the instructions on Tideways Profiler website
        to import your application settings:

        https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
