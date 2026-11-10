require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.19.2"
    checksum = {
        "macos-arm64" => "261fe08752f58c880d0f689f945330473841d423d70a9e974f45fcb4d26819c8",
        "macos-amd64" => "bc7297d57de3789610e6af0a2dad80101d8adeaf6aeb7a8566fc41cef4500731",
        "linux-aarch64" => "a26bc958968a6dcaa03bea93f29a837a5581157f3e2e2c0e35313b258463cfb0",
        "linux-amd64" => "476087130bf2965e4bf387a92275fbc37459df136fdfcb9588466376bf5e88fd",
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
