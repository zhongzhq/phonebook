class Settings < Settingslogic
  source File.expand_path('../config.yml', __FILE__)
  namespace Rails.env
end