require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version '1.9.2'

    if Hardware::CPU.arm?
      url 'https://tideways.s3.amazonaws.com/daemon/1.9.2/tideways-daemon_macos_arm64-1.9.2.tar.gz'
      sha256 '434f1f1b46c038b810b727d850dfadfe2136d0e00ed1a4200e34d847fbb3c78b'
    else
      url 'https://tideways.s3.amazonaws.com/daemon/1.9.2/tideways-daemon_macos_amd64-1.9.2.tar.gz'
      sha256 '7b04577b15891881860553e7097be6280db705cf52d7931f1e9869c9ad7cf6ba'
    end

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

