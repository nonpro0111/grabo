class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :sidebar

  def sidebar
    @popular_videos = Video.popular
    @tags = ActsAsTaggableOn::Tag.most_used(20)
    @advertisements = Advertisement.all
  end

end
