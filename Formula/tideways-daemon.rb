require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.6"
    checksum = {
        "macos-arm64" => "adb976e0eb8e6b48a67617f22bec45ee01152a1ccac89c7cdca439b1451f1198",
        "macos-amd64" => "3da094a08b987e5b5c5b4ff173b8c87e73c2c43fc6d737f318b6702c0cb68f70",
        "linux-aarch64" => "62af4e94507261186adcbdd746d0e13ad5e8ba09725a3a781d8d891b52c9e291",
        "linux-amd64" => "e1ae03c05a63589f54b4be434750e3967d43b4c92481882f5608f93e240b9574",
    }

    if OS.linux?
        os = "linux"
        arch = Hardware::CPU.arm? ? "aarch64" : "amd64"
    else
        os = "macos"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    end

    url "https://tideways.s3.amazonaws.com/daemon/#{version}/tideways-daemon_#{os}_#{arch}-#{version}.tar.gz"
    sha256 checksum["#{os}-#{arch}"]

    def install
        bin.install 'tideways-daemon'
    end

    def post_install
        (var/"log/tideways").mkpath
    end

    service do
        run [opt_bin/"tideways-daemon", "--address", "127.0.0.1:9135", "--env", "development"]
        log_path var/"log/tideways/daemon.log"
    end

    test do
        system opt_bin/"tideways-daemon", "-version"
    end

    def caveats
        <<~EOS

        Please contact support@tideways.com if you have problems setting up the daemon.

        EOS
    end
end
