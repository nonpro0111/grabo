class IdolsController < ApplicationController

  def index
    @idol_names = Idol.pluck(:name)
  end

  def show
    @idol = Idol.find(params[:id])
    @videos = @idol.videos.order(id: :desc).page(params[:page])
    unless @videos.present?
      @another_videos = Video.includes(:idols).order("RAND()").limit(10).page(params[:page])
    end
    @result_heading = "#{@idol.name}  #{@videos.size}件"
  end

  def search
    word = params[:search].gsub(/(\s|　)+/, "")
    idols = Idol.where("name like ?", "%#{word}%")
    @videos = Video.joins(:idols).merge(idols).page(params[:page])
    @result_heading = "#{params[:search]}検索結果  #{@videos.size}件"

    render :show
  end
end
