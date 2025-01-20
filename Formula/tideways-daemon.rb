require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.32"
    checksum = {
        "arm64" => "de8594d4e8de7d618e5261ec0201c82a552a1e21966edcb758f7b1ef04df2c88",
        "amd64" => "56470be1767827b7d9e3b30578060bca024b2152b0842f0a01854458ac25bbba",
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
