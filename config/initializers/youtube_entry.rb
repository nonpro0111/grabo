class Feedjira::Parser::AtomEntry
  element 'media:thumbnail', :value => :url, :as => :media_thumbnail_url
  element 'media:description', :as => :summary

  def video_title
    title.chars.select{|c| c.bytesize < 4 }.join('')
  end

  def video_description
    summary.chars.select{|c| c.bytesize < 4 }.join('') if summary
  end

  def video_thumbnail
    media_thumbnail_url
  end

  def video_embed_code
    links.first.match(/watch\?v=(\w+)/)[1]
  end

  def video_url
    links.first
  end
end
