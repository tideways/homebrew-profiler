require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.38"
    checksum = {
        "arm64" => "f97f966c7b4e156e181b24668f7f3c6c11f48c77b35a73df4c18a23b0dcb1456",
        "amd64" => "e4eb4dea1f012d8efdae065afbb42850bc7ccb112fc6922b95ed1fc57b4d64df",
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
