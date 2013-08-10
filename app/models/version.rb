class Version < ActiveRecord::Base

  def self.config
     YAML::load(File.read(Rails.root.to_s + '/config/version.yml'))
  end

end
