require File.expand_path("../../Abstract/abstract-tideways-php-extension.rb", __FILE__)

class Php55Tidewaysprofiler < AbstractTidewaysPhpExtension
  def self.init opts=[]
    super()
    depends_on "php55" => opts if build.with?('homebrew-php')
  end

  init
end
