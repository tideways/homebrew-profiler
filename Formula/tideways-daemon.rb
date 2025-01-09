require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.30"
    checksum = {
        "arm64" => "7399ed3a16896918e2a4d77407dc9bccf0fb10591d42010e49a4b725619f0690",
        "amd64" => "121afc3f19049c82bf750ca3d47afaf2ff882548b1e164eaa660761bb4c956dc",
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
