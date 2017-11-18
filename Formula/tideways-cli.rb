require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'

    url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.3.1/tideways-cli_0.3.1_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.3.1/tideways-cli_0.3.1_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha256 'd7d2379e6e5e360c342fc0e61aa932c08eacfa22205f439f549208563828e788' if MacOS.prefer_64_bit?
    sha256 'dbc5538458d485938f25285092eead8e1c6cdfeae5aa72ea6d6441ed8f79cdb5' if not MacOS.prefer_64_bit?
    version 'v0.3.1'

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
