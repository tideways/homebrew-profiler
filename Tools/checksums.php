<?php

function calculate_checksums($formula, $version)
{
    $url32 = "https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/{$formula}_macos_amd64-{$version}.tar.gz";
    $url64 = "https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/{$formula}_macos_i386-{$version}.tar.gz";
    $sha32 = sha1(file_get_contents($url32));
    $sha64 = sha1(file_get_contents($url64));

    $formulaFile = __DIR__ . "/../Formula/" . $formula . ".rb";
    $lines = file($formulaFile);

    $lines = array_filter($lines, function ($line) {
        $line = trim($line);
        return (strpos($line, "url '") !== 0 && strpos($line, "sha1 '") !== 0 && strpos($line, "version '") !== 0);
    });

    $newLines = [
        "    url '" . $url64 . "'  if MacOS.prefer_64_bit?\n",
        "    url '" . $url32 . "'  if not MacOS.prefer_64_bit?\n",
        "    sha1 '" . $sha64 . "' if MacOS.prefer_64_bit?\n",
        "    sha1 '" . $sha32 . "' if not MacOS.prefer_64_bit?\n",
    ];

    file_put_contents($formulaFile, array_merge(array_slice($lines, 0, 5), $newLines, array_slice($lines, 5)));
}

function fetch_url($code, $architecture)
{
    $architectureMatcher = ($architecture === 64)
        ? 'if MacOS.prefer_64_bit\?'
        : 'if not MacOS.prefer_64_bit\?';
    if (preg_match('(url \'([^\']+)\' ' . $architectureMatcher . ')', $code, $match)) {
        return $match[1];
    }

    throw new \RuntimeException("Could not find url.");
}

if (!in_array($argv[1], ['tideways-daemon', 'tideways-cli'])) {
    echo "php Tools/checksums.php <formula> <new-version>\n";
    exit(1);
}

calculate_checksums($argv[1], $argv[2]);
