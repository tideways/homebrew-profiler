require "formula"

class QafooprofilerDaemon < Formula
    homepage 'https://qafoolabs.com'

    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/qprofd_macos_amd64-0.4.1.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/qprofd_macos_i386-0.4.1.tar.gz' if not MacOS.prefer_64_bit?
    sha1 '34799122a28c49eb96433b81001e85c4cf2ed6f8' if MacOS.prefer_64_bit?

    def bin_name
        if MacOS.prefer_64_bit?
           return "qprofd_darwin_amd64"
        else
           return "qprofd_darwin_386"
        end
    end

    def install
       bin.install bin_name

       (var+"qprofd").mkpath
       (var+"run").mkpath
    end

    def plist; <<-EOS.undent
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
                <string>--address=#{var}/run/qprofd.sock</string>
                <string>--log=#{var}/qprofd/qprofd.log</string>
                <string>--env=development</string>
              </array>
              <key>RunAtLoad</key>
              <true/>
              <key>WorkingDirectory</key>
              <string>#{var}</string>
            </dict>
            </plist>
        EOS
    end
end

