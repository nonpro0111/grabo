class VideosController < ApplicationController

  def index
    @videos = Video.order(published_at: :desc).includes(:tags).page(params[:page])
  end

  def show
    @video = Video.find_by(id: params[:id])
    redirect_to root_path and return unless @video

    @video.increment!(:pv)
    @relation_videos = @video.relations

    tag_name = @video.tagging? ? @video.tag_list.first : ""
    set_dmm_affiliate(tag_name)
  end

  def search
    tag_name = params[:search]
    @videos = Video.tagged_with(tag_name).order(id: :desc).page(params[:page])
    @result_heading = "#{tag_name}  #{@videos.size}件"
  end

  def feed
    @videos = Video.order(created_at: :desc).limit(5)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
    def set_dmm_client
      @client = DMM.new(
        api_id: Rails.application.secrets.dmm_api_id, 
        affiliate_id: Rails.application.secrets.dmm_afi_id
      )
    end

    def set_dmm_affiliate(keyword)
      num = request_smartphone? ? 4 : 8
      begin
        @affiliates = idol_dmm_afi(num, "rank", keyword)
        if @affiliates.size < num
          shortage = num - @affiliates.size
          @affiliates << idol_dmm_afi(shortage, "date")
          @affiliates.flatten!
        end
      rescue => e
        logger.error("----- DMM Afiliate -----")
        logger.error("keyword: #{keyword}")
        logger.error(e.message)
      end
    end
end
