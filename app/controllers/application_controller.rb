class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def recommend_videos
    @recommend_videos = Video.order("RAND()").limit(6)
  end
end
