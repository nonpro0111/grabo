class IdolsController < ApplicationController

  def index
    @idol_names = Idol.pluck(:name)
  end

  def show
    @idol = Idol.find(params[:id])
    @videos = @idol.videos.order(id: :desc).page(params[:page])
    @result_heading = "#{@idol.name}  #{@videos.size}件"
  end
end
