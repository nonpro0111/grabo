class Feedjira::Parser::RSSEntry

  def video_title
    title.chars.select{|c| c.bytesize < 4 }.join('')
  end

  def html_content
    Nokogiri::HTML(summary)
  end

  def video_description
    html_content.css('body').first.text
  end

  def video_thumbnail
    html_content.css('img').first.attributes["src"].value
  end

  def video_embed_code
    url.match(/kobj_up_id=(\w+)/)[1]
  end

  def video_url
    url
  end
end
