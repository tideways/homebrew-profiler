require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.0"
    checksum = {
        "arm64" => "11fb21ec8c366bbdc32473262c0852c0f33d3e1f133edd9ff559fa6cd9a42d58",
        "amd64" => "7ab69ccf2af4a798aa7a97251784fb9694aa0d08a2a87e9a4aac9f4e1bbadcf3",
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
