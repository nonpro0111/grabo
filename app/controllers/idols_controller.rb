class IdolsController < ApplicationController

  # tagをもとにアイドル一覧を表示
  def index
    @idols = Global.idols.list
  end
end
