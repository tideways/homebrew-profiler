require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.9.48"
    checksum = {
        "macos-arm64" => "ed2b3e4d03e4332575f0b536100eca6598ed6f64ba87311bc2423301e99e7b91",
        "macos-amd64" => "a52c3345fa0b33c331d04cf7aa394f871c9d9908b5dbeced16ccb366c0c9a096",
        "linux-aarch64" => "6a48519d60338ac8f139be23dc7092199d5efea25c1c4451d8cb1dd61075a27e",
        "linux-amd64" => "e68dfd07048a96daa46db71b02b6ca5e65371d0757c02ed00f7b2afb738adf22",
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
