class PublicController < ActionController::Base #ApplicationController
  layout "default"
  def index
  end

  def help
  end

  def about
  end

  def version
    @versions = Version.config
  end
end
