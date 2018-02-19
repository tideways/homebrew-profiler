require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.3.3/tideways-cli_0.3.3_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.3.3/tideways-cli_0.3.3_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha256 '021571645f7564fee9810db488b3e1d3f9dfbfa886e566027d0d078d6d6124ba' if MacOS.prefer_64_bit?
    sha256 '58de57d79cc64ca5c8d05d89d9cefc39d4984225515abdc74bf51df6391d03b9' if not MacOS.prefer_64_bit?
    version 'v0.3.3'

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
