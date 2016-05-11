namespace :rss do
  desc "youtube rss 取得"
  task :from_youtube => :environment do
    puts "start rss:from_youtube"
    Feedjira::Feed.add_common_feed_entry_elements("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_elements("media:description", :as => :media_description)
    urls = Global.feeds.youtube
    urls.each do |url|
      feed = Feedjira::Feed.fetch_and_parse(url)
      videos = []
      last_entry = Video.where(channel: feed.title).order(:published_at).last
      feed.entries.each do |entry|
        next if last_entry && last_entry.published_at >= entry.published.localtime
        begin
          videos << Video.new(
                      title: entry.title,
                      thumbnail: entry.media_thumbnail_url.first,
                      original_site: 'youtube',
                      embed_code: entry.links.first.match(/watch\?v=(\w+)/)[1],
                      published_at: entry.published,
                      channel: feed.title,
                      url: entry.links.first,
                      description: entry.media_description.first
                    )
        rescue
          puts "error: #{feed.title}, #{entry.title}, #{entry.links.first}"
        end
      end
      Video.import(videos)
    end
    puts "end rss:from_youtube"
  end
end
