<?php

$phpVersions = ['8.0', '8.1', '8.2', '8.3'];

$formulaTemplate = <<<FORMULA
# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-tideways-php-extension", __dir__)

class TidewaysPhpAT{PHP} < AbstractTidewaysPhpExtension
  init

  if Hardware::CPU.arm?
    url "https://s3-eu-west-1.amazonaws.com/tideways/extension/{VERSION}/tideways-php-{VERSION}-macos-arm.zip"
    sha256 "{HASH_ARM}"
  else
    url "https://s3-eu-west-1.amazonaws.com/tideways/extension/{VERSION}/tideways-php-{VERSION}-macos-x86.zip"
    sha256 "{HASH_X86}"
  end

  version "{VERSION}"

  def install
    prefix.install "tideways-php-#{php_version}.so"
    write_config_file
  end
end

FORMULA;

$currentVersions = json_decode(file_get_contents("https://app.tideways.io/api/current-versions"), true);
$extensionVersion = $currentVersions['php']['version'] ?? throw new RuntimeException("Current Tideways extension version not found in current versions payload.");
$architectures = ['arm', 'x86'];
$hashes = [];

foreach ($architectures as $architecture) {
    $archive = file_get_contents('https://s3-eu-west-1.amazonaws.com/tideways/extension/' . $extensionVersion . '/tideways-php-' . $extensionVersion . '-macos-' . $architecture . '.zip');

    if ($archive === false) {
        throw new RuntimeException("Could not download MacOS archive for Tideways extension version " . $extensionVersion);
    }

    $hashes[$architecture] = hash('sha256', $archive);
}


foreach ($phpVersions as $phpVersion) {
    file_put_contents(__DIR__ . '/../Formula/tideways-php@' . $phpVersion . '.rb',
    str_replace(
        ['{PHP}', '{VERSION}', '{HASH_ARM}', '{HASH_X86}'],
        [str_replace('.', '', $phpVersion), $extensionVersion, $hashes['arm'], $hashes['x86']],
        $formulaTemplate
    ));
}
