require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.11.4"
    checksum = {
        "macos-arm64" => "e5f484a9a4c3474bbabe742e22ff1c46e20c95f1437f0daf87db85cc07fb9d3b",
        "macos-amd64" => "3c6c12601406417654f85062f9af981a3548ceaa04c463e692b4c3277d0052b8",
        "linux-aarch64" => "e606bbdca07243683f2f6dedf9338baddded41ae0ee5e84dfc2dba23f99b56e3",
        "linux-amd64" => "c07895364a2268f1781e113a7670505e518c393aa2e8cab42fb1c22057f26d19",
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
