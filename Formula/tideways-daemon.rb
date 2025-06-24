require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.42"
    checksum = {
        "macos-arm64" => "b9cb8faa079e2b60dec078f77236e11c8577a12cafa2ff136d83c8cbfdc54f6c",
        "macos-amd64" => "42841b340d1f508bb6f7f56c96e952bbbdf3ddda107b33857570a07f25cb1735",
        "linux-aarch64" => "560002bdb377fb52a15338969fd10880e1261f6c355bb18a68b45fb83c8ecbdd",
        "linux-amd64" => "47bee274c7a7530c20048263d6d1a306f8657aa76ad7d1d842d63dfa74bdc0ed",
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
