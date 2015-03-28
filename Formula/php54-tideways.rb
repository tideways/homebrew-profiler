require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php54Tideways < AbstractTidewaysPhpExtension
  init
  homepage 'https://github.com/tideways/php-profiler-extension'
  head 'https://github.com/tideways/php-profiler-extension.git'
  version 'v1.4.0'

  depends_on 'pcre'
  depends_on 'curl'

  def self.init opts=[]
    super()
    depends_on "php54" => opts if build.with?('homebrew-php')
  end
end
