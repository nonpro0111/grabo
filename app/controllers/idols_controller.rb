class IdolsController < ApplicationController

  # tagをもとにアイドル一覧を表示
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end
end
