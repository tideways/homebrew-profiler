# Homebrew Formulas for Qafoo Profiler

With this repository you can install the Qafoo Profiler Daemon, Commandline-Tool and PHP Extension via Homebrew.

Requirements: [homebrew-php](https://github.com/Homebrew/homebrew-php)

1. Tap this repository

	    brew tap qafoolabs/homebrew-profiler

2. a.) Install PHP Extension (if you have `homebrew-php`)

	    brew install php53-qafooprofiler
	    brew install php54-qafooprofiler
	    brew install php55-qafooprofiler
	    brew install php56-qafooprofiler

2. b.) Install PHP using System PHP

        brew install php54-qafooprofiler --without-homebrew-php

3. Install Daemon

	    brew install qafooprofiler-daemon

4. Install Commandline Tool

	    brew install qafooprofiler-cli

## Feedback: Help us improve Installation

If using this homebrew recipe is at any point complicated for you or not
intuitive that is our mistake. Please help us improve installation by sending
notes to support@profiler.qafoolabs.com

## Acknowledgements

This work is based on [homebrew-php](https://github.com/Homebrew/homebrew-php)
and uses parts of their codebase to work with different PHP versions.

## License

Copyright (c) 2015-2014 Qafoo GmbH

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
