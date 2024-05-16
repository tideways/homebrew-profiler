# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT80 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.9.0/tideways-php-5.9.0-macos-arm.tar.gz"
    sha256 "8e8404b5c8c48dffd0323a336698cd62da4f9b87ab56eafd32ec4c393d650fb3"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.9.0/tideways-php-5.9.0-macos-x86.tar.gz"
    sha256 "648fe8666fa44f38ae41eed7477125faed8f373a64250cb32f8bcc31b5a799e0"
  end

  version "5.9.0"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
