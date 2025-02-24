require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.8"
    checksum = {
        "arm64" => "a2ddcc4213981e8c3b821f760a6130e67c3b38bb814c73275cfff818f028d24e",
        "amd64" => "fbe079badedae24204252e5c4651b6abb410ccd1fd55087a2b525d156009e8db",
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
