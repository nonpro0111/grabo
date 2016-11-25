require 'net/http'
class Video < ActiveRecord::Base
  has_many :idols_videos
  has_many :idols, through: :idols_videos

  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
  attr_accessor :tag_names

  scope :popular, -> { includes(:idols).order(pv: :desc).limit(10) }
  scope :within_two_month, -> { where("created_at > ?", 2.month.ago) }

  def set_tag_by_title
    strip_title = title.gsub(/(\s|　)+/, '')

    idol_list = Idol.all
    idol_list.each do |idol|
      idols << idol if strip_title.index(idol.name)
    end
  end

  def set_tag(tag_names)
    tag_names.split(",").each { |name| tag_list.add(name) }
  end

  def banned?
    uri = URI.parse(URI.escape(thumbnail))
    Net::HTTP.get_response(uri).code == '404'
  end

  def idol_names
    idols.pluck(:name)
  end

  def relations
    Video.includes(:idols).order("RAND()").limit(10)
  end

  def add_one_word
    return unless idols.exists?

    idol = idol_names.first
    one_word = Description.one_word(idol)
    self.description = "" if self.description.nil?
    self.description += "\n\n" + one_word
  end
end
