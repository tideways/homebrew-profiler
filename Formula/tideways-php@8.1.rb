# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT81 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://tideways.s3.amazonaws.com/extension/5.8.0/tideways-php-5.8.0-macos-arm.tar.gz"
    sha256 "3846836b9a3fa99908d35ffa7131629508bb73859b4bb9dc6a9ae96dcf6f5f21"
  else
    url "https://tideways.s3.amazonaws.com/extension/5.8.0/tideways-php-5.8.0-macos-x86.tar.gz"
    sha256 "990ab47f5626ab053ddfac7b3962103afe38e630bc1ad3cdd84c2fb0f14e5049"
  end

  version "5.8.0"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
