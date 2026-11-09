require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.4.0"
    checksum = {
        "macos-arm64" => "62f31e8dadad265e4d84e5afff03d792ce12d55889f89a47d654f7468ea3dd67",
        "macos-amd64" => "2520fee9fcd5fe99d9d6995b73b12c19bcf5a771d78d523b42cabc84da487538",
        "linux-arm64" => "a3350c74417c8ffe0423dc7c8a52679a86af7fbf2ae8bcf5039639654805076a",
        "linux-amd64" => "c3a99ba6c9ca3aad855d4cd5a5706a433ab62c53651f3b0f15fea359bfee2a76",
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
