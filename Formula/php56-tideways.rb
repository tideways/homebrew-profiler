require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php56Tideways < AbstractTidewaysPhpExtension
  def self.init opts=[]
    super()
    depends_on "php56" => opts if build.with?('homebrew-php')
  end

  init
end
