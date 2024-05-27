# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.9.2/tideways-php-5.9.2-macos-arm.tar.gz"
    sha256 "2cf274c47ead926deb10dd2fa9db425c2ec0508b73a3f715ddb656c28ffa149a"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.9.2/tideways-php-5.9.2-macos-x86.tar.gz"
    sha256 "f529c8cf5d7a085a9365fee5f4a33a3ee00949d77cb084d277198ebd4349813e"
  end

  version "5.9.2"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
