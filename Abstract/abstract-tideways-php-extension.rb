# typed: false
# frozen_string_literal: true
# https://raw.githubusercontent.com/shivammathur/homebrew-extensions/master/Abstract/abstract-php-extension.rb

# Abstract class for PHP extensions
class AbstractTidewaysPhpExtension < Formula
  desc "Tideways PHP Profiler Extension"
  homepage 'https://tideways.com'

  def initialize(*)
    super
    @priority = self.class.priority || "20"
  end

  def caveats
    <<~EOS
      To finish installing #{extension} for PHP #{php_version}:
        * #{config_filepath} was created,"
          do not forget to remove it upon extension removal."
        * Validate installation by running php -m
    EOS
  end

  test do
    output = shell_output("#{Formula[php_formula].opt_bin}/php -m").downcase
    assert_match(/#{extension.downcase}/, output, "failed to find extension in php -m output")
  end

  private

  attr_reader :priority

  delegate [:php_version, :extension] => :"self.class"

  def module_path
    opt_prefix / "#{extension}-php-#{php_version}.so"
  end

  def config_file_content
    <<~EOS
      ; See https://support.tideways.com/documentation/setup/configuration/configure-tideways-globally-via-php-ini.html
      extension="#{module_path}"
      tideways.api_key=
      tideways.connection=tcp://127.0.0.1:9135

      ; This setting is used if the current project is a "Profilng Space" by disabling any monitoring.
      tideways.monitor=none
    EOS
  rescue error
    raise error
  end

  def config_scandir_path
    etc / "php" / php_version / "conf.d"
  end

  def config_filepath
    config_scandir_path / "#{priority}-#{extension}.ini"
  end

  def write_config_file
    Dir[config_scandir_path / "*#{extension}*.ini"].each do |ini_file|
      rm ini_file
    end
    config_scandir_path.mkpath
    config_filepath.write(config_file_content)
  end

  class << self
    attr_reader :php_version, :extension

    attr_rw :priority

    def parse_extension(matches)
      @extension = matches[1].downcase if matches
      @extension.gsub("pecl", "").gsub("pdo", "pdo_").gsub("xdebug2", "xdebug").gsub(/phalcon\d+/, "phalcon")
    end

    def init
      class_name = name.split("::").last
      matches = /(\w+)AT(\d)(\d)/.match(class_name)
      @extension = "tideways"
      @php_version = "#{matches[2]}.#{matches[3]}" if matches
    end
  end
end
