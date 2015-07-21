require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.3_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.3_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha1 'e7784b9f04f275bf2482308da4cd40d5baf4a468' if MacOS.prefer_64_bit?
    sha1 '808d553241448c30a87c86cd1474367d4205b2af' if not MacOS.prefer_64_bit?

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
