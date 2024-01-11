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

    def plist; <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
              <key>KeepAlive</key>
              <true/>
              <key>Label</key>
              <string>#{plist_name}</string>
              <key>ProgramArguments</key>
              <array>
                <string>#{bin}/tideways-daemon</string>
                <string>--address=127.0.0.1:9135</string>
                <string>--log=#{var}/log/tideways/daemon.log</string>
                <string>--env=development</string>
              </array>
              <key>RunAtLoad</key>
              <true/>
              <key>WorkingDirectory</key>
              <string>#{HOMEBREW_PREFIX}</string>
            </dict>
            </plist>
        EOS
    end

    def caveats
        <<~EOS

        Please contact support@tideways.com if you have problems setting up the daemon.

        EOS
    end
end

