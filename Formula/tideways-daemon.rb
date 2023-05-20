require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version '1.8.28'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/daemon/1.8.26/tideways-daemon_macos_amd64-1.8.28.tar.gz'
    sha256 '33953995aca002777af6ada33c7ac5eaa8b1d960d154e5e4f0805a2752bfef16'

    def install
       bin.install 'usr/bin/tideways-daemon'

       log_dir = var+'log/tideways'
       log_dir.mkpath unless log_dir.exist?

       run_dir = var+'run'
       run_dir.mkpath unless run_dir.exist?
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
                <string>--address=#{var}/run/tidewaysd.sock</string>
                <string>--log=#{var}/tideways/daemon.log</string>
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

