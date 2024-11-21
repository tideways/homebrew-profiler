require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.26"
    checksum = {
        "arm64" => "c0f82d715329f06365da3fedea55aba32841cd75e96f5badcd15ee55122bb5f1",
        "amd64" => "b00e7126a211f1bb580ddccc40de5fe05eb2f8cf853736b958e090f28808c4ee",
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
