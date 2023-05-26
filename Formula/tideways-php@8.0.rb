# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
  init
  url "https://s3-eu-west-1.amazonaws.com/tideways/extension/5.5.18/tideways-php-5.5.18-macos-arm.tar.gz"
  sha256 "70362477568fd38edbc0178978481b6feed04b0b8d34667b77ef014dd3033010"
  version "5.5.18"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
