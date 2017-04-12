require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php53Tideways < AbstractTidewaysPhpExtension
    init
    homepage 'https://github.com/tideways/php-profiler-extension'
    head 'https://github.com/tideways/php-profiler-extension.git'
    url 'https://github.com/tideways/php-profiler-extension/archive/v4.1.2.zip'
    sha256 '620d01adf00dec0f46940c5af52adcd12e3aab94845873e3d9296ec44f56d017'
    version 'v4.1.2'

    def self.init opts=[]
        super()
        depends_on "php53" => opts if build.with?('homebrew-php')
    end
end
