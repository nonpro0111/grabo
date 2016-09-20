xml.instruct! :xml, :version => "1.0" 
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "グラビアBOX動画"
 
    @videos.each do |video|
      xml.item do
        xml.category video.tag_list.first
        xml.title video.title
        xml.description video.description
        xml.pubDate video.created_at.to_s(:rfc822)
        xml.guid "http://www.gravure-tube.xyz/videos/#{video.id}"
        xml.link "http://www.gravure-tube.xyz/videos/#{video.id}"
      end
    end
  end
end
