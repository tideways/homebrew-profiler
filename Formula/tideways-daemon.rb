require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.19.0"
    checksum = {
        "macos-arm64" => "e03544d1d357ef02c4d191a255280eef8fdeaa628b33bb1c8b050f9a1205d4b8",
        "macos-amd64" => "2b4122abdc873406da0cdeb9b65c9366e61ba1fe2129578df97699639375a814",
        "linux-aarch64" => "7255f4d097365c72d4fdcaa6ba38e66dc98ff98930c14ea20916c72e10773d3c",
        "linux-amd64" => "87fbd10420ca5fdfe87b9b3cdf8328f677d78c991366d53e57a06c21c8638bce",
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
