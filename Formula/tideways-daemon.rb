require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.18.0"
    checksum = {
        "macos-arm64" => "45c346ee33edf9b6223f887357abdac55812b2d0ccda85a33a6a3d4e6a4a7163",
        "macos-amd64" => "432b773d5d958b8362ee76fe2475d99d28d9580bf83aa54bd33f212556e679cb",
        "linux-aarch64" => "5b1689c7fbe4835dfdce6d313b34fef45651024e2ffd825c5474d7c0355c00b1",
        "linux-amd64" => "b26e71213c4649b716888e2187190728595e4d005e6590531fcdb7290cf73395",
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
