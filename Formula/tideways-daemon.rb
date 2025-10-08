require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.11.2"
    checksum = {
        "macos-arm64" => "706d3a6b7cad5a3a4147937afcb25afd4ceb046b450c9de5adb0440ec28880d4",
        "macos-amd64" => "7cccc5b7da6e1bf3825f5a28a120cfe3d79d5279aa64080f45472cde241917d3",
        "linux-aarch64" => "e78244fce316d3c6dca7b33f4b2cd969db9c6c97e13c239b70841ce5a884555c",
        "linux-amd64" => "72c82afd7df4c734e52fa1afd6ea09fb6f63ab18c4fa4e0e5c53ab7b98ee214d",
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
