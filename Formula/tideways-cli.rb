require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.18"
    checksum = {
        "macos-arm64" => "dddc05158936588a907fab0555ce09ab566181be13bef963d08850967c89e8a0",
        "macos-amd64" => "e6cf454c0de523a9abb77e1d8bcd27acfff9a131f696acf5070168d8f77c12b6",
        "linux-arm64" => "f7f5816baab321cfb2ba53c5542eada5f76b87109d6b6de22e6bbe572f7d1ef4",
        "linux-amd64" => "f935d059a67af9a857732f0a89b87b56ea9a7252e0948dc52675b9a8c8e6b808",
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

    test do
        system opt_bin/"tideways", "version"
    end

    def caveats
        return <<~EOS
        Follow the instructions on Tideways Profiler website
        to import your application settings:

        https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
