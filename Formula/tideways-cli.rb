require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.3.0"
    checksum = {
        "macos-arm64" => "f3042bd2e34a9e804d3a1352ce15becf8d1d4baf2e9b423d1acdfe6fc1f20072",
        "macos-amd64" => "2908a51d3e79d00b3fffd8b9cc1c322bba48f0e08ade5afa45c577b1250c362a",
        "linux-arm64" => "44d1ea8bb74a009bd13b9be18b7aec6687d17c8de11383904b766745ce6defb2",
        "linux-amd64" => "8cbd212d169654edd93d35083ab23fa7d6da247b59fe16db2d78ffc772067747",
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
