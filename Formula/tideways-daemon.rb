require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.44"
    checksum = {
        "macos-arm64" => "e0ac14b052b71bbde11a2546a85d6c00ebfb8048ea2574808fdf702f21c4faa3",
        "macos-amd64" => "11975d57abb2eb25445b7ee34bda023572ef5b1445e6eabba5662da0fb4ac2aa",
        "linux-aarch64" => "d6713ad571ea9f270c823be32886676e05526a4d0760e2141e017aed18dc262f",
        "linux-amd64" => "273b12c94a8ab87e26b1d4aa37eac575fae736f964145166b297e960bb224597",
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
