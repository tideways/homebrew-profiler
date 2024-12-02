require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.28"
    checksum = {
        "arm64" => "4f06c65ebdf92982dbf8af37436f66c46d10246810c5196448d2c255b8a34321",
        "amd64" => "fa68e2c494330b79eb5c1a6d385cf88318ce51ad2596f1a1014d8d6c59d91986",
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
