require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.3_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.3_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha256 '651b9ce8b77dd8f0021458ad95789e13530737d3fd8d141555cd0b151033481d' if MacOS.prefer_64_bit?
    sha256 'dbc5538458d485938f25285092eead8e1c6cdfeae5aa72ea6d6441ed8f79cdb5' if not MacOS.prefer_64_bit?
    version 'v0.2.3'

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
