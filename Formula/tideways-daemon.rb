require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.40"
    checksum = {
        "macos-arm64" => "69bed9014607e049ba2ae13f56554b22d7f7374c8cbc846e2677fbbce1831ac6",
        "macos-amd64" => "8b97de3104434bc1c65dbff618d02765abd0c2aeb7d7e6f9794df8f4958fb260",
        "linux-aarch64" => "d98ab61ef42804f3c3bc4c993e3c324e38dcfdb6f8fb33abc249ea1d49d9b237",
        "linux-amd64" => "e94e95abdd3cb49991e09cd995b2bfaa395f0a5fe25ab08838936f521d17bda8",
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

    def caveats
        <<~EOS

        Please contact support@tideways.com if you have problems setting up the daemon.

        EOS
    end
end
