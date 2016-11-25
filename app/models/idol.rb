class Idol < ActiveRecord::Base
  has_many :idols_videos
  has_many :videos, through: :idols_videos
end
