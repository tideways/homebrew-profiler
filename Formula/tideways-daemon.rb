require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.16"
    checksum = {
        "arm64" => "17a2ddd19666cbb3a22ee62dec31595af3489ae8ed396244c34785328469d331",
        "amd64" => "74e1c75078d316f06e3df3e0a61eb2df4e5e2777f3d6c6d1ebaa769b5ba2dbfb",
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
