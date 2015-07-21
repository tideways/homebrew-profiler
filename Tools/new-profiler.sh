#!/bin/bash
perl -pi -e "s/v$1/v$2/g" Formula/php*.rb
