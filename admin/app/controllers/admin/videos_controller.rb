require_dependency "admin/application_controller"

module Admin
  class VideosController < ApplicationController
    before_action :set_video, only: [:edit, :update, :destroy]

    def index
      @videos = Video.all.order(created_at: :desc).page(params[:page]).per(30)
    end

    def new
      @video = Video.new
    end

    def create
      @video = Video.new(video_params)
      @video.set_tag(video_params[:tag_names])
      @video.published_at = Time.current

      if @video.save
        redirect_to edit_video_path(@video)
      else
        redirect_to new_video_path
      end
    end

    def edit
    end

    def update
      if video_params[:tag_names].present?
        @video.set_tag(video_params[:tag_names])
      end

      if @video.update(video_params)
        redirect_to videos_path
      else
        render :edit
      end
    end

    def destroy
      @video.tag_list.clear
      @video.destroy
      redirect_to short_desc_index_videos_path
    end

    private

      def set_video
        @video = Video.find(params[:id])
      end

      def video_params
        params.require(:video)
          .permit(:title, :thumbnail, :original_site, :embed_code,
                  :published_at, :channel, :url, :description, :pv, :tag_names)
      end
  end
end
