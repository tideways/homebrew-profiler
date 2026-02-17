require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.14.0"
    checksum = {
        "macos-arm64" => "5bd13277b534d64821c3b672e87f56531b5a1241206e90ea766234440d2c3a7f",
        "macos-amd64" => "e43b2d217d4c130a375d088c94c32f5d007d8ec8910bf79494e6ae68959611cf",
        "linux-aarch64" => "c33721c6f9915a9f0717b304a146d8ffb9cd02d47b9e68566a67f18356221efe",
        "linux-amd64" => "4f7d92a997e9641ada43f29a3b546138187b1e37ac2ba287a29896b30fe50e31",
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
