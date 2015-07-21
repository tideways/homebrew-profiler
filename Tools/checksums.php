<?php

function calculate_checksums($formula)
{
    $code = file_get_contents(__DIR__ . "/../Formula/" . $formula . ".rb");

    $url64 = fetch_url($code, 64);
    $url32 = fetch_url($code, 32);

    $sha64 = sha1(file_get_contents($url64));
    $sha32 = sha1(file_get_contents($url32));

    echo "    url '" . $url64 . "'  if MacOS.prefer_64_bit?\n";
    echo "    url '" . $url32 . "'  if not MacOS.prefer_64_bit?\n";
    echo "    sha1 '" . $sha64 . "' if MacOS.prefer_64_bit?\n";
    echo "    sha1 '" . $sha32 . "' if not MacOS.prefer_64_bit?\n";
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

calculate_checksums($argv[1]);
