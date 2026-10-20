require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.16"
    checksum = {
        "macos-arm64" => "c417eb4e2d6d848ceaf0abc776c7094dc51263139e2049801a849536b5d76d39",
        "macos-amd64" => "362336fa45195cf950fe1aeba03c02a5373e49b930c66820adf511d619afd0bb",
        "linux-aarch64" => "367aae5d71bb5d6115d2e09033adfdec873e173ad9344006aa204089fa1ef79d",
        "linux-amd64" => "f4ad43660e3941870007a0a1b843597bc4ac5f2169ff5fee1675fce7b15b8587",
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
