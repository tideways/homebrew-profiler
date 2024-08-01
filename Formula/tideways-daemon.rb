require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.6"
    checksum = {
        "arm64" => "04b13ee7129be45ed030d14eaa94ee92527baf4c7296fb37d898f78f46110469",
        "amd64" => "2b86ae2d4191bcb0d177144ea2ce819f52a571ba313f342fdcd3eeb4be9fcd05",
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
