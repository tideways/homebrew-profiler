require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.2"
    checksum = {
        "arm64" => "e0de2152f6dff1bf419ca518e184ec07be99df90e6493c96bfa042f9ba893422",
        "amd64" => "45f09397ad6bff37d6cbfdd6fb39ab49a0232167b9d8f39f667cec9a6e65a03e",
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
