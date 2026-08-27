require "formula"

class TidewaysCli < Formula
    homepage 'https://tideways.com'
    version "1.3.2"
    checksum = {
        "macos-arm64" => "f74aa16354ca84e7a7ebe6ab6ab9d556ef9c22877596e107c82dd4ff3f44b496",
        "macos-amd64" => "513803dc81287e396e323ac3a6bb57a25157f2ff892d9dbe9e5de16141a8e86e",
        "linux-arm64" => "a8ec9109ba296a2584d18b50805ea870875b0940e189ddf0dd7ec0780de43a52",
        "linux-amd64" => "e9aac78fcd8e0f9cca634b84ce29a2a1eb83e2546843df58ad3fda2be4b55b7f",
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
