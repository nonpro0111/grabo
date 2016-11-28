class VideosController < ApplicationController

  def index
    @videos = Video.order(published_at: :desc).includes(:idols).page(params[:page])
  end

  def show
    @video = Video.find_by(id: params[:id])
    redirect_to root_path and return unless @video

    @video.increment!(:pv)
    @relation_videos = @video.relations
    idol_name = @video.idols.first.try(:name)
    set_dmm_affiliate(idol_name)

    # 複数アイドルの組み合わせなどは考えず、
    # Idolレコードが1レコードのもののみ扱う
    # 1レコードのものがほとんどなので十分だと思う
    idol_id = @video.idols.pluck(:id).first

    if idol_id
      video_ids = @relation_videos.map(&:id)
      request_idol_ids = Idol.joins(:videos).merge(Video.where(id: video_ids)).pluck(:id)
      RelevanceScore.update_or_create_score(idol_id, request_idol_ids)

      match = request.referer.try(:match, /videos\/(\d*)$/)
      if match
        referer_video = Video.find(match[1])
        referer_idol_id = referer_video.idols.pluck(:id).first
        relevance_score = RelevanceScore.find_by(
                            referer_idol_id: referer_idol_id,
                            request_idol_id: idol_id
                          )
        relevance_score.increment!(:click_count) if relevance_score
      end
    end
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
