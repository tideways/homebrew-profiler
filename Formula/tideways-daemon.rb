require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.2"
    checksum = {
        "macos-arm64" => "3181c3ad9b47b8a1a2dd01acc56f195990d969412ea9c7d1541655e238c6938e",
        "macos-amd64" => "c670c3c88f4c37df351de3a4697a6f84185622c1ef6a48f478a5f262122a3af2",
        "linux-aarch64" => "b73f95b49dc6e57eb79a9da0cbccc64afc7363d68dd3b8281b24e8c886645179",
        "linux-amd64" => "df84af91b5139bc9e032aab378377bc1a1e0d70e9e2653694ea1c61275ac73fb",
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
