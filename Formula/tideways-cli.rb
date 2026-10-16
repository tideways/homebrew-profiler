require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.3.4"
    checksum = {
        "macos-arm64" => "a939286e823f685377fd6d4d661aff6e49f96e4bd3cd7e6e5e0feea3056480ef",
        "macos-amd64" => "556cc63f953c419ae2076c9b900993ec0dce624d3a01590c844dd6883538839d",
        "linux-arm64" => "6f0b7ebca4867ef0b86f62a91157ba0681c3a4d12ceb71c4c83454d73edb8f6f",
        "linux-amd64" => "1aee2c642df2e43d06e8bb4ed58b99b25b415e4dbc6a3bda0edcbd79c62e8ea5",
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
