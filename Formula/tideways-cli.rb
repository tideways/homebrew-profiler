require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.io'
    version 'v0.4.4'

    if Hardware::CPU.arm?
        url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.4.4/tideways-cli_macos_arm64-0.4.4.tar.gz'
        sha256 'b113e0703e7f4580f4821142032b58c9ce030ee70d376ed14b5f2dc2272263a5'

        def install
            bin.install "tideways"
        end
    end

    if Hardware::CPU.intel?
        url 'https://s3-eu-west-1.amazonaws.com/tideways/cli/0.4.4/tideways-cli_macos_amd64-0.4.4.tar.gz'
        sha256 '087f0f4e195061d995222fdd5e2dfcceefe0a6878f9fe81eed7b61b1ab008f2f'

        def install
            bin.install "tideways"
        end
    end

    def caveats
        return <<~EOS
          Follow the instructions on Tideways Profiler website
          to import your application settings:

          https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
