# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.7.4/tideways-php-5.7.4-macos-arm.tar.gz"
    sha256 "7737eb301073800b83c56d25186af3a69f42a15a0a9594811829954687a4ca2d"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.7.4/tideways-php-5.7.4-macos-x86.tar.gz"
    sha256 "3ad3ce0969d7ed910aa93c94d391882c3e158d22a523ad0c069bddf62843a7c2"
  end

  version "5.7.4"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
