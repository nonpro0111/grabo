namespace :rss do
  desc "youtube rss 取得"
  task :from_youtube => :environment do
    urls = Global.feeds.youtube
    urls.each do |url|
      feed = Feedjira::Feed.fetch_and_parse(url)
      videos = []
      last_entry = Video.where(channel: feed.title).order(:published_at).last
      feed.entries.each do |entry|
        next if last_entry && last_entry.published_at >= entry.published.localtime
        videos << Video.new(
                    title: entry.title,
                    thumbnail: entry.image,
                    original_site: 'youtube',
                    embed_code: entry.links.first.match(/watch\?v=(\w+)/)[1],
                    published_at: entry.published,
                    channel: feed.title,
                    url: entry.links.first
                  )
      end
      Video.import(videos)
    end
  end
end
