require_dependency "admin/application_controller"

module Admin
  class VideosController < ApplicationController
    before_action :set_video, only: [:edit, :update, :destroy]

    def index
      @videos_num = Video.all.size
    end

    def short_desc_index
      @videos = Video.where("description < ?", 30).page(params[:page]).per(30)
    end

    def edit
    end

    def update
      if video_params[:tags].present?
        @video.set_tag
      end

      if @video.update(video_params)
        redirect_to short_desc_index_videos_path
      else
        render :edit
      end
    end

    def destroy
    end

    private

      def set_video
        @video = Video.find(params[:id])
      end

      def video_params
        params.require(:video)
          .permit(:title, :thumbnail, :original_site, :embed_code,
                  :published_at, :channel, :url, :description, :pv)
      end
  end
end
