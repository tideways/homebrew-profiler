require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.4"
    checksum = {
        "arm64" => "406911bb4211529c9d2c8cb40e0b5184b887d262d9d144d1089a355997880904",
        "amd64" => "0f8d0f17ace07fbf4d3b52b7e64a19da0a5478996517d0a95bd0e8090d6e2485",
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
