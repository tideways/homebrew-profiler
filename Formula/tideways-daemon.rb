require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.4"
    checksum = {
        "macos-arm64" => "67cd79ca14554368f4c3b77ae58a154cf8babd53ec8ebd174fb69fb5e7d8232c",
        "macos-amd64" => "e6875dc8ea03852ab350376e8f32521202f97a5e0c154b5d7bc80e83c3db2cb7",
        "linux-aarch64" => "44d5171bbdd43c11b979d7b4735a3fca0a5337e44024a5670ca4f58c04349314",
        "linux-amd64" => "2132b3c3c4a5f6626ba2ff8256770aff6872876df99b53c2da205c7ee2831627",
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
