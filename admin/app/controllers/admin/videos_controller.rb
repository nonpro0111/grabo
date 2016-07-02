require_dependency "admin/application_controller"

module Admin
  class VideosController < ApplicationController
    def index
      @videos_num = Video.all.size
    end
  end
end
