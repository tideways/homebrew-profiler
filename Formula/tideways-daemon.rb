require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.36"
    checksum = {
        "arm64" => "b88eea38eee78f7d815eb3453264255f7da8993e0ac6bb9ffc9ec0eb7410eb6c",
        "amd64" => "d60de6ba4f092b76dc39ef2911d7080f96f37d917fb8dd4501d7f24c61b53caa",
    }

    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    url "https://tideways.s3.amazonaws.com/daemon/#{version}/tideways-daemon_macos_#{arch}-#{version}.tar.gz"
    sha256 checksum[arch]

    def install
        bin.install 'tideways-daemon'

        log_dir = var+'log/tideways'
        log_dir.mkpath unless log_dir.exist?
    end

    service do
        run [opt_bin/"tideways-daemon", "--address", "127.0.0.1:9135", "--log", HOMEBREW_PREFIX/"var/log/tideways/daemon.log", "--env", "development"]
    end

    def caveats
        <<~EOS

        Please contact support@tideways.com if you have problems setting up the daemon.

        EOS
    end
end
