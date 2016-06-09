class VideosController < ApplicationController

  def index
    @videos = Video.order(published_at: :desc).includes(:tags).page(params[:page])
  end

  def show
    @video = Video.find(params[:id])
    @video.increment!(:pv)
    
    if @video.tagging?
      tag_name = @video.tags.first.name
      @display_tag_name = @video.tags.first.name
      random_videos = Video.order("RAND()").limit(2)
      same_tag_videos = Video.tagged_with(tag_name).limit(3)
      @relation_videos = same_tag_videos + random_videos
    else
      @relation_videos = Video.order("RAND()").limit(5)
    end

    tag_name ||= ActsAsTaggableOn::Tag.most_used(5).sample.name
    set_dmm_affiliate(tag_name)
  end

  def search
    tag_name = params[:search]
    video_count = Video.tagged_with(tag_name).size
    @videos = Video.tagged_with(tag_name).page(params[:page])
    @result_heading = "#{tag_name}  #{video_count}件"
  end

  def feed
    @videos = Video.order(created_at: :desc).limit(5)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
    def set_dmm_client
      @client = DMM.new(:api_id => ENV['DMM_API_ID'], :affiliate_id => ENV['DMM_AFI_ID'])
    end

    def set_dmm_affiliate(keyword)
      begin
        set_dmm_client
        @affiliates = @client.product(:site => 'DMM.com', :keyword => keyword.force_encoding("utf-8"), :service => 'digital', :floor => 'idol', :sort => 'rank', :hits => 3).result[:items]
        if @affiliates.size < 3
          num = 3 - @affiliates.size
          @affiliates << @client.product(:site => 'DMM.com', :service => 'digital', :floor => 'idol', :sort => 'rank', :hits => num).result[:items]
          @affiliates.faltten!
        end
      rescue => e
        logger.error("----- DMM Afiliate -----")
        logger.error("keyword: #{keyword}")
        logger.error(e.message)
      end
    end
end
