require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version 'v1.0.7'

    if Hardware::CPU.arm?
        url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/1.0.7/tideways-cli_macos_arm64-1.0.7.tar.gz'
        sha256 '93a50a4d42041bdf89ab7ad3a7fb3d532bd486393620db854266dc8fa6357613'
    else
        url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/1.0.7/tideways-cli_macos_amd64-1.0.7.tar.gz'
        sha256 'b5abef4af7e3a8bd247488e59896250595c79920547baa6c51902fc9ee274c3f'
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
