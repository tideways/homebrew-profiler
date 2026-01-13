require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.12.0"
    checksum = {
        "macos-arm64" => "3b02a838a8b2794367c3488efa8f41df7376ae5b30d8586aba9017bb554180e0",
        "macos-amd64" => "7336e42a816218a047666f7c354b2133dba6a9e948644168f7b181565e86fbea",
        "linux-aarch64" => "cec9364a1020eafebf2b5186d3baf0ddfa5c0f3f237059c4444719cfa63d1590",
        "linux-amd64" => "68f1bbf8e11ef1a6ee6fbbc47dee1538b041bee0064b5110d35e93c93b2e6967",
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
