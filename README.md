# Homebrew Formulas for Tideways Profiler

With this repository you can install the Tideways Profiler Daemon, Commandline-Tool and PHP Extension via Homebrew.

> **Warning:** This only works with homebrew PHP installations for now.

1. Tap this repository

	    brew tap tideways/homebrew-profiler

2. Install PHP Extension (if you have `homebrew-php`)

	    brew install tideways-php@8.0
	    brew install tideways-php@8.1
	    brew install tideways-php@8.2
            brew install tideways-php@8.2

4. Install Daemon

	    brew install tideways-daemon

5. Install Commandline Tool

	    brew install tideways-cli

## Feedback: Help us improve Installation

If using this homebrew recipe is at any point complicated for you or not
intuitive that is our mistake. Please help us improve installation by sending
notes to [support@tideways.com](mailto:support@tideways.com).

## Acknowledgements

This work is based on [homebrew-php](https://github.com/Homebrew/homebrew-php)
and [shivamathur/homebrew-extensins](https://github.com/shivammathur/homebrew-extensions)
and uses parts of their codebase to work with different PHP versions.

## License

Covers code in this repository only: https://github.com/tideways/homebrew-profiler

Copyright (c) 2014-2023 Tideways GmbH

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
