require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.16"
    checksum = {
        "macos-arm64" => "bf787621d113d12002793cd7672baad1216a04353ea0334c9fb8a6f2106a59a5",
        "macos-amd64" => "745b1c4127510624fa822486c7e0123ca4beebf59caadae5bc4baa85b9421531",
        "linux-arm64" => "0ba03e144f8cd53f0534dbc0eeacf0516b8dc671f015a4b9bd4a7d6af428150d",
        "linux-amd64" => "77208aeb82311dbb96ec28b0a6fe1dcfaa64b125e9e2b265c7bea2b140a6ded6",
    }

    if OS.linux?
        os = "linux"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    else
        os = "macos"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    end

    url "https://tideways.s3.amazonaws.com/cli/#{version}/tideways-cli_#{os}_#{arch}-#{version}.tar.gz"
    sha256 checksum["#{os}-#{arch}"]

    def install
        bin.install "tideways"
    end

    test do
        system opt_bin/"tideways", "version"
    end

    def caveats
        return <<~EOS
        Follow the instructions on Tideways Profiler website
        to import your application settings:

        https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
