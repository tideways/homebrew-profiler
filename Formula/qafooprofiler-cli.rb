require "formula"

class QafooprofilerCli < Formula
    homepage 'https://qafoolabs.com'

    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/qafoo-profiler-cli_0.1.10_macos_amd64.tar.gz' if MacOS.prefer_64_bit?
    url 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/downloads/qafoo-profiler-cli_0.1.10_macos_i386.tar.gz' if not MacOS.prefer_64_bit?
    sha1 'a02c1dba5365161da079c9bc130e83dee55dbe0c' if MacOS.prefer_64_bit?
    sha1 '62c6b953612e7a5b7a5acbdb623f207e1ad3f3d3' if not MacOS.prefer_64_bit?

    def install
        bin.install "qprofile"
    end 

    def caveats
        return <<-EOS.undent
          Follow the instructions on Qafoo Profiler website
          to import your application settings:

          https://profiler.qafoolabs.com/user/cli-import-settings
        EOS
    end
end
