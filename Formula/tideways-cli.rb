require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.12"
    checksum = {
        "macos-arm64" => "384b448e8f3fa85b7f890954061a3b1b9b81742a85ac75a9a135eb0b3c8efe8a",
        "macos-amd64" => "b9ed11579eeba4be4a221084572ebf27773064a3848392aafb8f7400126bc571",
        "linux-arm64" => "31452c0cd374de2dfe66b28b2a9b5ec7e3fb4968d9f982149171e465fdb543ed",
        "linux-amd64" => "4ac5d50cd5dac69a45f44f42189070756a2c795ed85dbb967ec56b901f91e53a",
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
