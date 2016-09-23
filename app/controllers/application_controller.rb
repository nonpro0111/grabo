class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :sidebar, :lower_ad
  include DmmAffiliate
  helper_method :request_smartphone?
  helper_method :request_pc?

  def sidebar
    @popular_videos = Video.popular
    @tags = ActsAsTaggableOn::Tag.most_used(20)
    @sidebar_ads = Advertisement.sidebar
  end

  def lower_ad
    @lower_ads = global_dmm_afi(12)
  end

  def request_smartphone?
    begin
      request.env["HTTP_USER_AGENT"].include?("Mobile")
    rescue
      false
    end
  end

  def request_pc?
    !request_smartphone?
  end
end
