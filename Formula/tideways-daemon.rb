require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.14"
    checksum = {
        "macos-arm64" => "96ba7ec044328c85be4d36d042d62d0251bd771daa0ca3f4acadb441f24466ed",
        "macos-amd64" => "70b752fee166159d1132ba60f836c26ca74e31b33dac2ee85d97de5b6899905a",
        "linux-aarch64" => "041e524bff7a483b20f111baaf738ae14484ded67c5ab301f4b701195aa71a69",
        "linux-amd64" => "25061c3b9412355932e594e9558356f8156898f7304e2f9050517d95b29acd74",
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
