require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version 'v1.0.8'

    if Hardware::CPU.arm?
        url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/1.0.8/tideways-cli_macos_arm64-1.0.8.tar.gz'
        sha256 '6b40adb7875887ec306f28cdd62eb862a0e6a4ee36ddd63b34ee29e8a8ff8abc'
    else
        url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/1.0.8/tideways-cli_macos_amd64-1.0.8.tar.gz'
        sha256 'c1a46822dcf15404b9b8a81b1f6e64d632844d5d5286efb74c61d587b140c0cc'
    end

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
