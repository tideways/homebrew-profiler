require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version 'v1.1.0'

    if Hardware::CPU.arm?
        url 'https://tideways.s3.amazonaws.com/cli/1.1.0/tideways-cli_macos_arm64-1.1.0.tar.gz'
        sha256 'bc4e2346129bde1b5c5ba4a30fbfb6b1ac8ab9e9af9236bf0eecc277139ad312'
    else
        url 'https://tideways.s3.amazonaws.com/cli/1.1.0/tideways-cli_macos_amd64-1.1.0.tar.gz'
        sha256 'a09bc9f06717101892b120fe92dedf27702be5189a98fdce979a1348ca8b68ad'
    end

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
