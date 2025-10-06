require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.11.0"
    checksum = {
        "macos-arm64" => "8d49bf5543d812cf85fff4cc48000ff2ca9d3f150051bdce50987c14a3de8938",
        "macos-amd64" => "1f382bbd78e22c0588bf92acd665503d2947a9faab4abfbae9d1fb5a16f1b1a7",
        "linux-aarch64" => "30f824f9281d0898833afc599b6f4c89eda55d2cce0de0245b0e25eacc2b00ad",
        "linux-amd64" => "edd37da9286404a998718face826da12a6d2245abd5761ea5e3fd8ec33fa64a9",
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
