require File.expand_path("../../Abstract/abstract-tideways-php-extension", __FILE__)

class Php54Tidewaysprofiler < AbstractTidewaysPhpExtension
  def self.init opts=[]
    super()
    depends_on "php54" => opts if build.with?('homebrew-php')
  end

  init
end