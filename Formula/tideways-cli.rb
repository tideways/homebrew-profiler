require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.1_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.1_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha1 'eaf1664090945c9ccd8b55914109725f073e0042' if MacOS.prefer_64_bit?
    sha1 'da91ca8d06b0f44b9029908112c18517fca9a7ff' if not MacOS.prefer_64_bit?

    def install
        bin.install "tideways"
    end 

    def caveats
        return <<-EOS.undent
          Follow the instructions on Tideways Profiler website
          to import your application settings:

          https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
