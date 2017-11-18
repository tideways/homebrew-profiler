# Homebrew Formulas for Tideways Profiler

With this repository you can install the Tideways Profiler Daemon, Commandline-Tool and PHP Extension via Homebrew.

Requirements: [homebrew-php](https://github.com/Homebrew/homebrew-php)

1. Tap this repository

	    brew tap tideways/homebrew-profiler

2. a.) Install PHP Extension (if you have `homebrew-php`)

	    brew install php53-tideways
	    brew install php54-tideways
	    brew install php55-tideways
	    brew install php56-tideways
	    brew install php70-tideways
	    brew install php71-tideways
	    brew install php72-tideways

    If you get an error about a missing "php.h", then try again with the flag --env=std

	    brew install php71-tideways --env=std

    **Notice: The installer uses PHPs "auto_prepend_file" to load the Tideways.php library.
    This is different from how the Linux version of Tideways works. Make sure that
    the `/usr/local/etc/php/7.1/conf.d/ext-tideways.ini` contains the `auto_prepend_file`
    directive.

2. b.) Install PHP using System PHP

        brew install php54-tideways --without-homebrew-php

3. Install Daemon

	    brew install tideways-daemon

4. Install Commandline Tool

	    brew install tideways-cli

## Feedback: Help us improve Installation

If using this homebrew recipe is at any point complicated for you or not
intuitive that is our mistake. Please help us improve installation by sending
notes to [support@tideways.io](mailto:support@tideways.io).

## Acknowledgements

This work is based on [homebrew-php](https://github.com/Homebrew/homebrew-php)
and uses parts of their codebase to work with different PHP versions.

## License

Copyright (c) 2014-2017 Tideways GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
