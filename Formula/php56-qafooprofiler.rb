require File.expand_path("../../Abstract/abstract-qafoo-php-extension", __FILE__)
require 'net/http'

class Php56Qafooprofiler < AbstractQafooPhp56Extension
  init
  homepage 'https://github.com/qafoolabs/php-profiler-extension'
  url 'https://github.com/qafoolabs/php-profiler-extension/archive/v1.3.7.tar.gz'
  sha1 '88722ed49a4a3f10bcf12946e503a6068d29d19b'
  head 'https://github.com/qafoolabs/php-profiler-extension.git'
  version 'v1.3.7'

  depends_on 'pcre'

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                            phpconfig
    system "make"
    prefix.install "modules/qafooprofiler.so"

=begin
    Net::HTTP.start("github.com") do |http|
        resp = http.get("/QafooLabs/profiler/releases/download/v1.3.5/QafooProfiler.php")
        open(prefix / "modules/QafooProfiler.php", "wb") do |file|
            file.write(resp.body)
        end
    end
=end

    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      qafooprofiler.connection=#{var}/run/qprofd.sock
    EOS
  end
end