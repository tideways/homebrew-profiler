require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.3.6"
    checksum = {
        "macos-arm64" => "c19e9aeaa322ddbe9f054b2fe72e45fff1eb6867c4241c6b455c85e896251c65",
        "macos-amd64" => "26ad2ba6d7395a21ed8adaac07115abf2de9097ee57d08b82b28e9bd456442ea",
        "linux-arm64" => "6d97240977bf0ba1b9a5b08325131205fc3e3a8341245924a3226898f806c0a7",
        "linux-amd64" => "380f3497d9f5af7699bab447f464b310771900e01fad5e50fccabc1f2c25d205",
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
