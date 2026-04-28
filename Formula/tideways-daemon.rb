require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.17.0"
    checksum = {
        "macos-arm64" => "78f109209706dfbe39455b179b8aef73a657557d9482fe9f0a8a9ece2855df43",
        "macos-amd64" => "d7109d5a328ac22f6e2ff723d93f65a047cf8ad11fcd59347d12417a5c74674e",
        "linux-aarch64" => "4ecc2a945f0d99cdf3cb33e724d839c8ca3663680a256068ecc7543197dceccb",
        "linux-amd64" => "493d7042cd99f7fddf5fde58010aa81d98cab18b713e347e56552fdd52661120",
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
