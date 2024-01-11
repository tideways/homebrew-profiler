require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version '1.8.28'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/daemon/1.8.28/tideways-daemon_macos_arm64-1.8.28.tar.gz'
    sha256 'a7e58a7411b52b76a97977d2aa7a5ddb21a3f3b316553779a09a054c864018bf'

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

