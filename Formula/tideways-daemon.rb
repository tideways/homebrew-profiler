require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.10"
    checksum = {
        "arm64" => "d82172b87db1271691dac2a40ae97273ead468c5946ab8099fc8d2d544f6be12",
        "amd64" => "52181abfdecfb92d5e9f3b03642ae63cc59ae5071343099224e076bc9c6567d9",
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
