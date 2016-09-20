class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :sidebar, :lower_ad
  helper_method :request_smartphone?
  helper_method :request_pc?

  def sidebar
    @popular_videos = Video.popular
    @tags = ActsAsTaggableOn::Tag.most_used(20)
    @sidebar_ads = Advertisement.sidebar
  end

  def lower_ad
    @lower_ads = Advertisement.lower
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
