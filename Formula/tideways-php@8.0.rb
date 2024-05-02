# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.8.4/tideways-php-5.8.4-macos-arm.tar.gz"
    sha256 "6aeb0a78b10faec312450cdb92e8186b563de169777b06c6610b75149355b4db"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.8.4/tideways-php-5.8.4-macos-x86.tar.gz"
    sha256 "1558c43818ae8ea257bdcae7aaea3b3ac275c373f777255021b7c4e4a22ac564"
  end

  version "5.8.4"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
