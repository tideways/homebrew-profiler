require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.12"
    checksum = {
        "arm64" => "9e1ae74e5f0056433401f22820aad45150917f680ed8a0ffe9d35c2782939024",
        "amd64" => "1e44ed778f0f9f0f808c0fee78ae92ad6edfa42264d5756eb84bb100f902cfdc",
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
