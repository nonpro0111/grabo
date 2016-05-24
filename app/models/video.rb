require 'net/http'
class Video < ActiveRecord::Base
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス

  scope :popular, -> { order(pv: :desc).limit(4) }

  def self.youtube_new(feed, entry)
    title = entry.title.chars.select{|c| c.bytesize < 4 }.join('')
    description = entry.media_description.first
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

  def banned?
    uri = URI.parse(URI.escape(thumbnail))
    Net::HTTP.get_response(uri).code == '404'
  end

  def tagging?
    tag_list.present?
  end
end
