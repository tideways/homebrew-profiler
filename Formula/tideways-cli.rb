require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.0_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/tideways-cli_0.2.0_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha1 '72aed7435f24a6b93aabce98500b7c3164d49d98' if MacOS.prefer_64_bit?
    sha1 '25d8905bc04886836fbaecec84d56c7fd9105033' if not MacOS.prefer_64_bit?

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
