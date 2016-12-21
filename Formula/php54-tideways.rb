require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php54Tideways < AbstractTidewaysPhpExtension
    init
    homepage 'https://github.com/tideways/php-profiler-extension'
    head 'https://github.com/tideways/php-profiler-extension.git'
    url 'https://github.com/tideways/php-profiler-extension/archive/v4.0.7.zip'
    sha256 'c3e7b243de695d38026e1741a385bbd664f450d5bd786a98d5c5c4858a7494d9'
    version 'v4.0.7'

    def self.init opts=[]
        super()
        depends_on "php54" => opts if build.with?('homebrew-php')
    end
end
