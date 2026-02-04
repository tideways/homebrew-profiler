require "formula"

class TidewaysDaemon < Formula
    homepage 'https://tideways.com'
    version "1.13.0"
    checksum = {
        "macos-arm64" => "ee4a6021dfe893647667684eb2daf67e9d5c3804db6dbde73d6cfe10bc9001ef",
        "macos-amd64" => "57886607957dbc2a40730044a9899bbfde5ccffcd9f60f715f756540dc017a38",
        "linux-aarch64" => "0e92daef0e62541f7a8d526406598c47645b783c60804aef74ea0aa229572f24",
        "linux-amd64" => "2b60a72a84307ded6927c6df24e16dfcebcaa91cd9de0314d9474e49ba082ad6",
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
