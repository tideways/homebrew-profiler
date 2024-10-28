require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.22"
    checksum = {
        "arm64" => "dca680454b7c5679d5c5ff5f0e0b7b01c1b12201bbf0c911f44116e66256c421",
        "amd64" => "3cf2fd103bae16388324283e86b9a4bfae5e70bf797a6f5f97d9f33d8d6b6919",
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
