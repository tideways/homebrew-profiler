require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.17.4"
    checksum = {
        "macos-arm64" => "da0dfbf3b5f9c657b47de43f662dcd2606e06b60c2ec8c0df39e2178067a151e",
        "macos-amd64" => "cc827d6c7c501e9d7c404413bde03be1c1b8f9fac1b98b92c3a313a6812bca6c",
        "linux-aarch64" => "14c3a103b6f9c523a526aab385ec09627b78158f15a7f54139de83f4cbc6ef88",
        "linux-amd64" => "5929d6af1c5a40d816f27c90cc29563e2b5863d8b6a7e6c2825c05bd49412b2b",
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
