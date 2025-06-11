# typed: false
# frozen_string_literal: true
# https://raw.githubusercontent.com/shivammathur/homebrew-extensions/master/Abstract/abstract-php-extension.rb

class AbstractTidewaysPhpExtension < Formula
  desc "Tideways PHP Profiler Extension"
  homepage 'https://tideways.com'

  def caveats
    <<~EOS
      To finish installing tideways for PHP #{php_version}:
        * #{pkgetc/"tideways.ini"} was created,
          do not forget to remove it upon extension removal.
        * Validate installation by running php -m
    EOS
  end

  test do
    output = shell_output("#{Formula[php_formula].opt_bin}/php -m").downcase
    assert_match(/tideways/, output, "failed to find extension in php -m output")
  end

  private

  delegate [:php_version] => :"self.class"

  def module_path
    opt_prefix/"tideways-php-#{php_version}.so"
  end

  def config_filepath
    etc/"php"/php_version/"conf.d"/"20-tideways.ini"
  end

  def write_config_file
    (buildpath/"tideways.ini").write <<~EOS
      ; See https://support.tideways.com/documentation/setup/configuration/configure-tideways-globally-via-php-ini.html
      extension="#{module_path}"
      tideways.api_key=
      tideways.connection=tcp://127.0.0.1:9135

      ; This setting is used if the current project is a "Profiling Space", disabling any monitoring.
      tideways.monitor=none
    EOS
    pkgetc.install buildpath/"tideways.ini"
    rm config_filepath if config_filepath.exist? && !config_filepath.symlink?
    ln_s pkgetc/"tideways.ini", config_filepath unless config_filepath.symlink?
  end

  class << self
    attr_reader :php_version

    def init
      class_name = name.split("::").last
      matches = /(\w+)AT(\d)(\d)/.match(class_name)
      @php_version = "#{matches[2]}.#{matches[3]}" if matches
    end
  end
end
