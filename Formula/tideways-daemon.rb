require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.52"
    checksum = {
        "macos-arm64" => "90c22f5b775a6eff621cb3b1f506ecba2064b6ceb61478ef118cc1cdef69ae5c",
        "macos-amd64" => "80248a8313dc3ffaf1ab729cd29f899585c0e13eab5a8ec9340100d6f7ece3fe",
        "linux-aarch64" => "69db40e7e16ded3a130de436be9dc7c755141e053435495c095a49b15d5a96f5",
        "linux-amd64" => "f0e1861756fbe2562fd44420718e7881dc09da6bee4b60f6a0d7662a82669263",
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
