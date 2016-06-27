require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php56Tideways < AbstractTidewaysPhpExtension
    init
    homepage 'https://github.com/tideways/php-profiler-extension'
    head 'https://github.com/tideways/php-profiler-extension.git'
    url 'https://github.com/tideways/php-profiler-extension/archive/v4.0.5.zip'
    version 'v4.0.5'

    def self.init opts=[]
        super()
        depends_on "php56" => opts if build.with?('homebrew-php')
    end
end
