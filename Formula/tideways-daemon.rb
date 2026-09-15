require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.8"
    checksum = {
        "macos-arm64" => "023136f240bfa128b2a03caa099dfb5b08e5b97a4f8c40585c8eaf0041328381",
        "macos-amd64" => "1759ab4f6cbf181a737e32c3c6dcc11ebb1ee697a0a2302f516e08619e49241c",
        "linux-aarch64" => "cbc259aa939ea3bc86399c46d8631d9a5a963d0b8f4a1237129578a34d5376de",
        "linux-amd64" => "97e563efc8a9741893fc0b2e74926058b86f06d6d99d6a11cb720f93aa6ad02d",
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
