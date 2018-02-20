require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/daemon/1.5.19/tideways-daemon_macos_amd64-1.5.19.tar.gz'
    sha256 'd1cdb43ca8870e7ea81be3e5a689302f012ef7d6e6d20f8c1679a8effba65b98'

    def bin_name
        return "tideways-daemon"
    end

    def install
       bin.install bin_name

       (var+"tideways").mkpath
       (var+"run").mkpath
    end

    def plist; <<~EOS
            <?xml version="1.0" encoding="UTF-8"?>
            <plist version="1.0">
            <dict>
              <key>KeepAlive</key>
              <true/>
              <key>Label</key>
              <string>#{plist_name}</string>
              <key>ProgramArguments</key>
              <array>
                <string>#{opt_bin}/#{bin_name}</string>
                <string>--address=#{var}/run/tidewaysd.sock</string>
                <string>--log=#{var}/tideways/daemon.log</string>
                <string>--env=production</string>
              </array>
              <key>RunAtLoad</key>
              <true/>
              <key>WorkingDirectory</key>
              <string>#{var}</string>
            </dict>
            </plist>
        EOS
    end

    def caveats
        <<~EOS

        (Re-)start the daemon after the installation with launchctl:

            launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.tideways-daemon.plist
            launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.tideways-daemon.plist

        If the plist entry is missing you can symlink it over to the correct directory:

            sudo ln -sfv /usr/local/Cellar/tideways-daemon/#{version}/*.plist ~/Library/LaunchAgents

        Please contact support@tideways.io if you have problems setting up the daemon.

        EOS
    end
end

