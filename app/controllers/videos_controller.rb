class VideosController < ApplicationController

  def index
    @videos = Video.order(created_at: :desc).includes(:tags).page(params[:page])
  end

  def show
    @video = Video.find(params[:id])
    
    if @video.tagging?
      tag_name = @video.tag_list.first
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
    @tag_name = params[:tag_name]
    @videos = Video.tagged_with(@tag_name).page(params[:page])
    set_dmm_affiliate(@tag_name)
  end

  private
    def set_dmm_client
      @client = DMM.new(:api_id => ENV['DMM_API_ID'], :affiliate_id => ENV['DMM_AFI_ID'], :result_only => true)
    end

    def set_dmm_affiliate(keyword)
      begin
        set_dmm_client
        @affiliates = @client.item_list('BiS', site: 'DMM.com',
                                      service: 'digital', floor: 'idol', hits: 3, keyword: keyword).items
        if @affiliates.empty?
          @affiliates = @client.item_list('BiS', site: 'DMM.com',
                                      service: 'digital', floor: 'idol', hits: 3).items
        end
      rescue => e
        logger.error("----- DMM Afiliate -----")
        logger.error("keyword: #{keyword}")
        logger.error(e.message)
      end
    end
end
