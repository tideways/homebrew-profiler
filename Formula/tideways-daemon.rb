require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.19.4"
    checksum = {
        "macos-arm64" => "fa8225d592b5c1348f3cfb83fedbdb69fafac62356bdbe09a89c6e5d39845a40",
        "macos-amd64" => "98b337b0b23ca3244af5f5c596fc6abd1e5f4247335103013793cd77285d941a",
        "linux-aarch64" => "a4c19ef7c18070f1c43c18908e4d6791aa43f08bb82660d7deaa3c12692b67fa",
        "linux-amd64" => "ffc9f4d50c064f9e28ad6a477d596d1515ff9c879a9a343303c87c41823926ae",
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
