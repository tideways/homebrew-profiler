require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.18"
    checksum = {
        "arm64" => "e21ed59fdb3c63adccd419f3c23731495f32751aa135e26716f1bd0acd42abc4",
        "amd64" => "80ea5dfc7764ebc5642bd2bb7033a382bea2d6c18d5ddb054c0c96bcb45f97dd",
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
