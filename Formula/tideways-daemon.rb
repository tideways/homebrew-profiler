require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.40"
    checksum = {
        "arm64" => "69bed9014607e049ba2ae13f56554b22d7f7374c8cbc846e2677fbbce1831ac6",
        "amd64" => "8b97de3104434bc1c65dbff618d02765abd0c2aeb7d7e6f9794df8f4958fb260",
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
