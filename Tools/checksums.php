<?php

function calculate_checksums($formula, $version)
{
    if ($formula === 'php') {
        $url = "https://github.com/tideways/php-xhprof-extension/archive/v{$version}.zip";
        $hash = hash('sha256', file_get_contents($url));

        $phpVersions = ['54', '55', '56', '70', '71', '72'];

        foreach ($phpVersions as $phpVersion) {
            $formulaFile = __DIR__ . "/../Formula/php{$phpVersion}-tideways.rb";
            replace_formula($formulaFile, $url, $hash, $version);
        }
    } else {
        $url = "https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/{$formula}_macos_amd64-{$version}.tar.gz";
        $hash = hash('sha256', file_get_contents($url));

        $formulaFile = __DIR__ . "/../Formula/" . $formula . ".rb";

        replace_formula($formulaFile, $url, $hash, $version);
    }
}

function replace_formula($formulaFile, $url, $hash, $version)
{
    $lines = file($formulaFile);

    for ($i = 0; $i < count($lines); $i++) {
        if (strpos(trim($lines[$i]), "url '") === 0) {
            $lines[$i] = "    url '" . $url . "'\n";
        } else if (strpos(trim($lines[$i]), "sha256 '") === 0) {
            $lines[$i] = "    sha256 '" . $hash . "'\n";
        } else if (strpos(trim($lines[$i]), "version '") === 0) {
            $lines[$i] = "    version '" . $version . "'\n";
        }
    }

    file_put_contents($formulaFile, implode("", $lines));
}

if (!isset($argv[2])) {
    echo "php Tools/checksums.php <formula> <new-version>\n";
    exit(1);
}

if (!in_array($argv[1], ['tideways-daemon', 'tideways-cli', 'php'])) {
    echo "php Tools/checksums.php <formula> <new-version>\n";
    exit(1);
}

calculate_checksums($argv[1], $argv[2]);
