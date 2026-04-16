require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.16.0"
    checksum = {
        "macos-arm64" => "31990876742b7c55378bb1d083c3119885fcd0f224190d71799a2b4cfd17fe63",
        "macos-amd64" => "38a49f6d850c69b4001b623db1ee3c84247a937ccd7e63f171b0ac57078aaa47",
        "linux-aarch64" => "d0621f7f027e019b149e2895ae41cd12dc76213869bbdce86a60ec31e06c2478",
        "linux-amd64" => "0fda43d1266c33328bc5fdb7c36b0d1dec181d755b331102417b99634ca1576a",
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
