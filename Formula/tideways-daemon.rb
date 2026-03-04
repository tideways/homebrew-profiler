require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.15.0"
    checksum = {
        "macos-arm64" => "aca2cdce61cfe0ad49b1e57c15462c9a3e3c73b7768764629265addc81530076",
        "macos-amd64" => "9c4856a51e1fb57e4200a88246c00aeea23758d4cbe086361df1be3997dcc12d",
        "linux-aarch64" => "626cfb2b20753349e101bc6f2b9896cd1cf4c3ea7d177fd4aa4c8a03241acde8",
        "linux-amd64" => "7b294e74084f9c1db1ea1f64f25704ad7b8cf08447304e334ab47aaf0c15c209",
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
