require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.10.0"
    checksum = {
        "macos-arm64" => "9c3d9de573b1576378a392e2885f99a261d7756995118508cf9621b346b08c4b",
        "macos-amd64" => "76c35c8dbc730006a5e29bee4860d9e7976dfee9e3833f3cbab9cacca44ceb12",
        "linux-aarch64" => "d06f52c191d948781301f07e1964c4a12195864f9793ca3f697db309c9e82272",
        "linux-amd64" => "5f12b04fb56074465c9629b5e07de864d004db90e800b729473c7f20f104e2c7",
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
