require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.14"
    checksum = {
        "macos-arm64" => "7dca4dfd8be999903f105c5fa965954df17a45cc2078f7f4259e38df46cf2d35",
        "macos-amd64" => "b4b37807824d2abefe57566054a644711a5f6302cd07ce03de2c76bc620d9d78",
        "linux-arm64" => "f229f268a6a3cf73807a05ce7af35facc605987f6c842bed08ce0e129822e941",
        "linux-amd64" => "7f1f21fc99954beb361b39366d442b7be31f3810ae5e55477a46ac908764d5cf",
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
