require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.15.2"
    checksum = {
        "macos-arm64" => "d67becf816131ff2af14f3717ac33916a117c2ffb791e73e6e0cacbf9b5c8b75",
        "macos-amd64" => "52adceab03b061e92daea63fd216b6df9a7075a62b32584852fe16f8bdedbb84",
        "linux-aarch64" => "15ffa60414e38adcdcb80384c89d8098e6f01df3ff46397f2841e164d8c11fcf",
        "linux-amd64" => "daa111094b8b96b13249b62687236ad9b5e73c1dd53ff065f27d10e150c5a43c",
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
