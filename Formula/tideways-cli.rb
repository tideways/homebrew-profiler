require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.10"
    checksum = {
        "macos-arm64" => "c6cb5373ccb4dee5a6377dce8bc87bce6a0c9b85ed63c925ded68b95a2426269",
        "macos-amd64" => "0792bb0af055752a6045f3d7c58ada3c86709305bf9319643e6683132d5c3ae1",
        "linux-arm64" => "6bfd07eb83522591b68b1242782029d520ffda5e871824f5a040934ac81fbb61",
        "linux-amd64" => "7545b05fed2b0d071efc0925ac153800b4529876c19db4101a552d7caf85a1e8",
    }

    if OS.linux?
        os = "linux"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    else
        os = "macos"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    end

    url "https://tideways.s3.amazonaws.com/cli/#{version}/tideways-cli_#{os}_#{arch}-#{version}.tar.gz"
    sha256 checksum["#{os}-#{arch}"]

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
