class VideosController < ApplicationController
  before_action :recommend_videos

  def index
    @videos = Video.order(published_at: :desc).page(params[:page])
  end

  def show
    @video = Video.find(params[:id])
    @relation_videos = Video.order("RAND()").limit(8)
  end
end
