require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version '1.8.40'

    if Hardware::CPU.arm?
      url 'https://tideways.s3.amazonaws.com/daemon/1.8.40/tideways-daemon_macos_arm64-1.8.40.tar.gz'
      sha256 '669ddeb9487ec5e946176729589233bf6bcff9677d8ceebaf6817b7f26c81035'
    else
      url 'https://tideways.s3.amazonaws.com/daemon/1.8.40/tideways-daemon_macos_amd64-1.8.40.tar.gz'
      sha256 '99de699ceda9c472efd8ce0bbaa9bf60a01dae73286f34c728a0c026f7361501'
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

