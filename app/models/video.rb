require 'net/http'
class Video < ActiveRecord::Base
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス

  scope :popular, -> { order(pv: :desc).limit(10) }

  class << self
    def youtube_new(feed, entry)
      title = entry.title.chars.select{|c| c.bytesize < 4 }.join('')
      description = entry.summary.first
      description = description.chars.select{|c| c.bytesize < 4 }.join('') if description

      Video.new(
        title: title,
        thumbnail: entry.media_thumbnail_url.first,
        original_site: 'youtube',
        embed_code: entry.links.first.match(/watch\?v=(\w+)/)[1],
        published_at: entry.published,
        channel: feed.title,
        url: entry.links.first,
        description: description
      )
    end

    def fc2_new(feed, entry)
      title = entry.title.chars.select{|c| c.bytesize < 4 }.join('')
      html_content = Nokogiri::HTML(entry.summary)
      description = html_content.css('body').first.text

      Video.new(
        title: title,
        thumbnail: html_content.css('img').first.attributes["src"].value,
        original_site: 'fc2',
        embed_code: entry.url.match(/kobj_up_id=(\w+)/)[1],
        published_at: entry.published,
        channel: feed.title,
        url: entry.url,
        description: description
      )
    end
  end

  def set_tag
    Global.idols.list.each do |idol|
      strip_title = title.gsub(/(\s|　)+/, '')
      tag_list.add(idol) if strip_title.index(idol)
    end
  end

  def banned?
    uri = URI.parse(URI.escape(thumbnail))
    Net::HTTP.get_response(uri).code == '404'
  end

  def tagging?
    tag_list.present?
  end
end
