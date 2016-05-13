class VideosController < ApplicationController

  def index
    @videos = Video.order(created_at: :desc).includes(:tags).page(params[:page])
  end

  def show
    @video = Video.find(params[:id])
    @relation_videos = Video.order("RAND()").limit(8)
  end

  def search
    @tag = params[:tag]
    @videos = Video.tagged_with(params[:tag]).page(params[:page])
  end
end
