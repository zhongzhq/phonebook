module Master
  class MasterController < ApplicationController
    load_and_authorize_resource :class => false

    def index
    end

  end
end
