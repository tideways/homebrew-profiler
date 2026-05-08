require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.17.2"
    checksum = {
        "macos-arm64" => "1b0de41a6c13bf5797f4dfab3888b2b61f77c48a2325600fcc76b726efd593a8",
        "macos-amd64" => "6e2fd2f23c76c7f8d9d5402c343470428b9126d48ddbf7b5a10d8499739f6c7b",
        "linux-aarch64" => "7271f9a895d5248ef630fe9175f7e8e8a301d5596d77715eb4e7fa04aaed64a1",
        "linux-amd64" => "8c3f273d0c4c56bafb3ad6b997c20b83d266f1d7733c448e448ebf1b4061fc35",
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
