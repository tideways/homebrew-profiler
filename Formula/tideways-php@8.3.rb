# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
  init
  version "5.10.2"

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-arm.tar.gz"
    sha256 "03f48d53e7b5ffd4ce4fe1a862c1a0fda784394fa4a871e1cc29a722f1811e2a"
  else
    url "https://tideways.s3.amazonaws.com/extension/#{version}/tideways-php-#{version}-macos-x86.tar.gz"
    sha256 "957adea7387c6ec906f9e15a3ce0e12b7ace028dd4fa4be3e69a173f7a355c8a"
  end

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
