require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.2.20"
    checksum = {
        "macos-arm64" => "453b795ca3096d83de6baa443c3ef69884df516e35bf9f38cebc13deb9047108",
        "macos-amd64" => "86517be6e45b4aa69f64beac2b665cb71c6fcbb541c5940181323bb52ba078f7",
        "linux-arm64" => "b3be029e6110f513e48b569fe3beed40592ba7a0bd3307de8574ead873cd0249",
        "linux-amd64" => "9e1c16b03dc479f1d20bb6125656b85854c38935998d37fbb1466330d44e5e84",
    }

    if OS.linux?
        os = "linux"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    else
        os = "macos"
        arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    end

    url "https://tideways.s3.amazonaws.com/cli/#{version}/tideways-cli_#{os}_#{arch}-#{version}.tar.gz"
    sha256 checksum["#{os}-#{arch}"]

    def install
        bin.install "tideways"
    end

    test do
        system opt_bin/"tideways", "version"
    end

    def caveats
        return <<~EOS
        Follow the instructions on Tideways Profiler website
        to import your application settings:

        https://app.tideways.io/user/cli-import-settings
        EOS
    end
end
