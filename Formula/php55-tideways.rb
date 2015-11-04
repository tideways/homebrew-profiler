require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php55Tideways < AbstractTidewaysPhpExtension
    init
    homepage 'https://github.com/tideways/php-profiler-extension'
    head 'https://github.com/tideways/php-profiler-extension.git'
    url 'https://github.com/tideways/php-profiler-extension/archive/v3.0.1.zip'
    version 'v3.0.1'

    depends_on 'pcre'

    def self.init opts=[]
        super()
        depends_on "php55" => opts if build.with?('homebrew-php')
    end
end
