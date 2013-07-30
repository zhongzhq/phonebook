class PublicController < ApplicationController
  def help
  end

  def about
  end

  def version
    @versions = Version.config
  end
end
