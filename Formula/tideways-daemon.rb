require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.46"
    checksum = {
        "macos-arm64" => "762013ccc0f0dac13901bff6f75a40edbe93433fae2712331025905d58799a78",
        "macos-amd64" => "d08b3fd75cb7d0bc0d6c2435bb4b2d2841508391f210f8c8cdf980d02cbefa03",
        "linux-aarch64" => "fda1aa0b9a95f5f155fbb40b15415a333e5e522c4be118804de96af8cff2ce43",
        "linux-amd64" => "4085e729a00da0f124554d8f89191f373250d6b27e0fc0e2f6a1aa885312f6ca",
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
