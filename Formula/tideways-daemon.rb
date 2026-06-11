require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.17.6"
    checksum = {
        "macos-arm64" => "bb058295d0a80bc3a114569497a964397f9e610f8819aa164a958ed633515f62",
        "macos-amd64" => "5a38ee41a0358dfaea8888dd636efe9c48b6150b6280ea1d16be28cdb6dbde7e",
        "linux-aarch64" => "604d1c5488b252411ca17ffe0c296761cc68670b553448735dc93ebf03fb260b",
        "linux-amd64" => "5e65eff26bfe41995a3354261bbb17e394483db316c19dad94c5efb81100c856",
    }

    if OS.linux?
        os = "linux"
        arch = Hardware::CPU.arm? ? "aarch64" : "amd64"
    else
        os = "macos"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    end

    url "https://tideways.s3.amazonaws.com/daemon/#{version}/tideways-daemon_#{os}_#{arch}-#{version}.tar.gz"
    sha256 checksum["#{os}-#{arch}"]

    def install
        bin.install 'tideways-daemon'
    end

    def post_install
        (var/"log/tideways").mkpath
    end

    service do
        run [opt_bin/"tideways-daemon", "--address", "127.0.0.1:9135", "--env", "development"]
        log_path var/"log/tideways/daemon.log"
    end

    test do
        system opt_bin/"tideways-daemon", "-version"
    end

    def caveats
        <<~EOS

        Please contact support@tideways.com if you have problems setting up the daemon.

        EOS
    end
end
