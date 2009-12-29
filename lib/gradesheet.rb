module Gradesheet
  # Allows accessing config variables from harmony.yml like so:
  # Harmony[:domain] => harmonyapp.com
  def self.[](key)
    unless @config
      raw_config = File.read(RAILS_ROOT + "/config/gradesheet.yml")
      @config = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
    end
    @config[key]
  end

  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
end