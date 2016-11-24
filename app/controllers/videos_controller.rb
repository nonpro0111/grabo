class VideosController < ApplicationController

  def index
    @videos = Video.order(published_at: :desc).includes(:idols).page(params[:page])
  end

  def show
    @video = Video.find_by(id: params[:id])
    redirect_to root_path and return unless @video

    @video.increment!(:pv)

    @relation_videos = @video.relations
    referer_id = @video.tags.first.try(:id)
    if referer_id
      # @videoがidolと紐付いていたら
      # RecommendStatisticレコードを作る
      #
      # videos#showからリクエストが来て
      # リクエスト元のvideoがidolと紐付いていたら
      # RecommendStatisticレコードを取得して+1する
      @relation_videos.each do |relation_video|
        request_id = relation_video.tags.first.try(:id)
        next unless request_id

        RelevanceScore.update_or_create_data(referer_id, request_id)
      end

      match = request.referer.match(/videos\/(\d*)$/)
      if match
        @referer_video = Video.find(match[1])
        referer_tag_id = @referer_video.tags.first.try(:id)
        @recommend_statistic = RelevanceScore.find_by(referer)
      end
    end

    binding.pry

    #

    idol_name = @video.idols.first.try(:name)
    set_dmm_affiliate(idol_name)
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
