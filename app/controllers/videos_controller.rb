class VideosController < ApplicationController
  before_action :recommend_videos

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end
end
