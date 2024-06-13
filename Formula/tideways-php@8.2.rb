# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT82 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.10.0/tideways-php-5.10.0-macos-arm.tar.gz"
    sha256 "4a15450e820ecfd3ee76e5e71ddb09d2429d850a29f313400ea609281bee5143"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.10.0/tideways-php-5.10.0-macos-x86.tar.gz"
    sha256 "6dab90691d916d9491e9373d1be055532c35fbf3dbbaffc49694450354d5f630"
  end

  version "5.10.0"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
