# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT83 < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://s3-eu-west-1.amazonaws.com/tideways/extension/5.6.10/tideways-php-5.6.10-macos-arm.zip"
    sha256 "e18a62dab82ae67e358b8d31cdb5c4f59fba44c093547826850d5f1ab87d3a70"
  else
    url "https://s3-eu-west-1.amazonaws.com/tideways/extension/5.6.10/tideways-php-5.6.10-macos-x86.zip"
    sha256 "450bab147cd7083a92b1d607ba6ba8f27188ca266d1269a8ecfaa54f5bef6b47"
  end

  version "5.6.10"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
