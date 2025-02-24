require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.34"
    checksum = {
        "arm64" => "038f8813f6f3bdce9249dfd5dcca8b07d63baee15ee5e759fc7358d3b249edf7",
        "amd64" => "9427c923e6cae6fb527708311f8c5c43b20464b323953aaae1773196857d173f",
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
