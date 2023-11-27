<?php

$phpVersions = ['8.0', '8.1', '8.2'];

$formulaTemplate = <<<FORMULA
# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT{PHP} < AbstractTidewaysPhpExtension
  init
  url "https://s3-eu-west-1.amazonaws.com/tideways/extension/{VERSION}/tideways-php-{VERSION}-macos-arm.tar.gz"
  sha256 "{HASH}"
  version "{VERSION}"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end
FORMULA;

$currentVersions = json_decode(file_get_contents("https://app.tideways.io/api/current-versions"), true);
$extensionVersion = $currentVersions['php']['version'] ?? throw new RuntimeException("Current Tideways extension version not found in current versions payload.");

$archive = file_get_contents('https://s3-eu-west-1.amazonaws.com/tideways/extension/' . $extensionVersion . '/tideways-php-' . $extensionVersion . '-macos-arm.tar.gz');

if ($archive === false) {
    throw new RuntimeException("Could not download MacOS archive for Tideways extension version " . $extensionVersion);
}

$archiveFile = sys_get_temp_dir() . '/macos.tar.gz';
file_put_contents($archiveFile, $archive);

$tarGz = new PharData($archiveFile);
$tarGz->decompress()->extractTo(sys_get_temp_dir());

foreach ($phpVersions as $phpVersion) {
    file_put_contents(__DIR__ . '/../Formula/tideways-php@' . $phpVersion, str_replace(
        ['{PHP}', '{VERSION}', '{HASH}'],
        [str_replace($phpVersion, '.', ''), $extensionVersion, $hash],
        $formulaTemplate
    ));
}
