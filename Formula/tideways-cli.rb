require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.4.0/tideways-cli_0.4.0_macos_amd64.tar.gz'
    sha256 'c85d50d697c4a2e13b301bc4a65df89504ba74d42bf98c766f4e38879ffdfcff'
    version 'v0.4.0'

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
