require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.8"
    checksum = {
        "arm64" => "0eabfa615fd9593bc5a5e24659273e63214b88165119d8934aba2d817fc53fb7",
        "amd64" => "51ef92dc4edd3f7c33fba616b531b7a17c7b8b16eb48cb81cd7b3f733fc55be0",
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
