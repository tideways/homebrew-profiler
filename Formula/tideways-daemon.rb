require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.12.2"
    checksum = {
        "macos-arm64" => "d5a3c374f51e8eb8c6eb3f8f377cb9c82662ff214a9f15f90d1f7225d483d27d",
        "macos-amd64" => "b5463ace7798305319868398aa5ecf014b5b8802dabf839f2d36399307e88f6e",
        "linux-aarch64" => "493b60fc252b6b04100894b3a77ba0c7d789d20b4107ed849107921c96cea007",
        "linux-amd64" => "9128fae5f64a70ec319cc302e8666fa1785f1ea78c18726a8979f1ca292d55fe",
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
