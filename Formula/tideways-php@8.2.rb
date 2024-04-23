# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.8.2/tideways-php-5.8.2-macos-arm.tar.gz"
    sha256 "7d7c5309c6b34496e4324e4b36bab76237ddaf2658edc72f9f6a76a0d099dd17"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.8.2/tideways-php-5.8.2-macos-x86.tar.gz"
    sha256 "2ac46a24ee8e9b0855037cce07a9908bdc639fe54714b754b50636a5040c9f89"
  end

  version "5.8.2"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
