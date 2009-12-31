module Gradesheet
  # Allows accessing config variables from gradesheet.yml like so:
  # Gradesheet[:domain] => gradesheetapp.com
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