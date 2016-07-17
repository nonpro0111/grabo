class Advertisement < ActiveRecord::Base
  mount_uploader :image, AdImageUploader

  scope :sidebar, -> { where(position: POSITON::SIDEBAR).order(:order_no) }
  scope :lower, -> { where(position: POSITON::LOWER).order(:order_no) }

  module POSITON
    SIDEBAR = 1
    LOWER   = 2

    NAMES = {
      1 => "サイドバー",
      2 => "ページ下部"
    }
  end

end
