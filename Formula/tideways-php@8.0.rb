# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.7.2/tideways-php-5.7.2-macos-arm.tar.gz"
    sha256 "0cbd6df09d1e6f4713558bda460a38fed52dc07460aeadc73457ec4b81f4f984"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.7.2/tideways-php-5.7.2-macos-x86.tar.gz"
    sha256 "b79eab7028b284f85b995b46c7fd360b6e3b401a8552ff22dd4eec96a30389f0"
  end

  version "5.7.2"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
