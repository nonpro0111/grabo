namespace :rss do
  desc "youtube rss 取得"
  task :from_youtube => :environment do
    puts "start rss:from_youtube"
    Feedjira::Feed.add_common_feed_entry_elements("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_elements("media:description", :as => :media_description)
    
    Global.feeds.youtube.each do |url|
      feed = Feedjira::Feed.fetch_and_parse(url)
      last_entry = Video.where(channel: feed.title).order(:published_at).last
      feed.entries.each do |entry|
        next if last_entry && last_entry.published_at >= entry.published.localtime
        begin
          video = Video.youtube_new(feed, entry)
          Global.idols.list.each do |idol|
            video.tag_list.add(idol) if video.title.index(idol)
          end
          video.save!
        rescue
          puts "error: #{feed.title}, #{entry.title}, #{entry.links.first}"
        end
      end
    end
    puts "end rss:from_youtube"
  end
end
