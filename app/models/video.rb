require 'net/http'
class Video < ActiveRecord::Base
  include Tag
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス
  attr_accessor :tag_names

  scope :popular, -> { includes(:tags).order(pv: :desc).limit(10) }
  scope :within_two_month, -> { where("created_at > ?", 2.month.ago) }

 # class << self
 #   def niconico_new(feed, entry)
 #     title = entry.title.chars.select{|c| c.bytesize < 4 }.join('')
 #     html_content = Nokogiri::HTML(entry.summary)
 #     description = html_content.css('body').css('.nico-description').text

 #     Video.new(
 #       title: title,
 #       thumbnail: html_content.css('img').first.attributes["src"].value,
 #       original_site: 'niconico',
 #       embed_code: entry.url.match(/watch\/(\w+)/)[1],
 #       published_at: entry.published,
 #       channel: feed.title,
 #       url: entry.url,
 #       description: description
 #     )
 #   end
 # end

  # mecabの人名精度がいまいちなので、config優先
  def set_tag_by_title
    strip_title = title.gsub(/(\s|　)+/, '')
    idol_name = get_tag_name(strip_title)

    is_matched = false
    Global.idols.list.each do |idol|
      if strip_title.index(idol)
        tag_list.add(idol)
        is_matched = true
      end
    end

    if idol_name.present? && !is_matched
      tag_list.add(idol_name)
    end
  end

  def set_tag(tag_names)
    tag_names.split(",").each { |name| tag_list.add(name) }
  end

  def banned?
    uri = URI.parse(URI.escape(thumbnail))
    Net::HTTP.get_response(uri).code == '404'
  end

  def tagging?
    tag_list.present?
  end

  # 関連動画一覧
  # 今は同じタグ３件、ランダム2件
  def relations
    if tagging?
      random_videos = Video.includes(:tags).order("RAND()").limit(5)
      same_tag_videos = Video.includes(:tags).tagged_with(tag_list).limit(3)
      same_tag_videos + random_videos
    else
      Video.includes(:tags).order("RAND()").limit(8)
    end
  end

  def add_one_word
    return unless tagging?
    idol = tag_list.first
    one_word = Description.one_word(idol)
    self.description = "" if self.description.nil?
    self.description += "\n\n" + one_word
  end
end
