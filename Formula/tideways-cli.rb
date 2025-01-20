require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.6"
    checksum = {
        "arm64" => "dd6b724fc36a24cfb681d9a9c6603466841c2276b831ae1bcf57b24db5125c9d",
        "amd64" => "0281a5c9470bd0b5b941625842df647aa751d781ed2c45f708e0e05f4b05b15c",
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
