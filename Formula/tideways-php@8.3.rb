# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.7.0/tideways-php-5.7.0-macos-arm.tar.gz"
    sha256 "b6a6ffd703c44a088ffb174719dfa6e68edd8e0ce9775639b1e5311d9151a3f5"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.7.0/tideways-php-5.7.0-macos-x86.tar.gz"
    sha256 "eb92c125c0298d8add4defeac8d801ca28b3528741fe5878d09cb6143023d35e"
  end

  version "5.7.0"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
