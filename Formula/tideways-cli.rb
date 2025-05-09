require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.10"
    checksum = {
        "arm64" => "c6cb5373ccb4dee5a6377dce8bc87bce6a0c9b85ed63c925ded68b95a2426269",
        "amd64" => "0792bb0af055752a6045f3d7c58ada3c86709305bf9319643e6683132d5c3ae1",
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
