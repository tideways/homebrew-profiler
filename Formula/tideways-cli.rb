require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.3.3/tideways-cli_0.3.3_macos_amd64.tar.gz'
    sha256 '021571645f7564fee9810db488b3e1d3f9dfbfa886e566027d0d078d6d6124ba'
    version 'v0.3.3'

    def install
        bin.install "tideways"
    end

    def caveats
        return <<~EOS
          Follow the instructions on Tideways Profiler website
          to import your application settings:

          https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
