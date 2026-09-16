require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.10"
    checksum = {
        "macos-arm64" => "43f897137e7457bdf01fa5a759d002a2837aa1c53302257f5f7093fa137f3166",
        "macos-amd64" => "3f4818032f4199211500d9ae73106f5a2637783a14c87726ac246f91bed20e21",
        "linux-aarch64" => "6a544b800dd3403eebc4dfc288d4b46b99450f8f2d7676f09b7291624f9109e4",
        "linux-amd64" => "200b2675da6799884e6dc0dae3b5b7d286c7eb48020ce8260c8e1cad4bbf4eba",
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
