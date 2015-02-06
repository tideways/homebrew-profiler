require File.expand_path("../../Abstract/abstract-qafoo-php-extension", __FILE__)

class Php56Qafooprofiler < AbstractQafooPhp56Extension
  init
  homepage 'https://github.com/qafoolabs/php-profiler-extension'
  url 'https://github.com/qafoolabs/php-profiler-extension/archive/master.tar.gz'
  sha1 'bcce54c971d69cb248c4a3e7b4d03f1b75fc2c55'
  head 'https://github.com/qafoolabs/php-profiler-extension.git'
  version 'master'

  depends_on 'pcre'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                            phpconfig
    system "make"
    prefix.install "modules/qafooprofiler.so"

    write_config_file if build.with? "config-file"
  end
end
