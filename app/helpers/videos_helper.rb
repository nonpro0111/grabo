module VideosHelper

  def clean_text(text)
    text.gsub(/\[\w.+\]/,'')
  end

  def embed_video(video)
    case video.original_site
    when 'youtube'
      html = "<iframe width=\"700\" height=\"393\" src=\"https://www.youtube.com/embed/#{video.embed_code}\" frameborder=\"0\" allowfullscreen></iframe>"
    when 'fc2'
      html = "<script src=\"http://static.fc2.com/video/js/outerplayer.min.js\" url=\"#{video.url}/\" tk=\"グラビアアイドル\" tl=\"#{video.title}\" sj=\"52000\" d=\"77\" w=\"448\" h=\"284\" suggest=\"on\" charset=\"UTF-8\"></script>"
    end

    raw(html)
  end
end
