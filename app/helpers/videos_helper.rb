module VideosHelper

  def clean_text(text)
    text.gsub(/\[\w.+\]/,'')
  end
end
