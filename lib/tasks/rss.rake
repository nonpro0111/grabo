namespace :rss do
  desc "youtube rss 取得"
  task :from_youtube => :environment do
    puts "start rss:from_youtube"
    video_count = 0 
    Global.feeds.youtube.each do |url|
      begin
        feed = Feedjira::Feed.fetch_and_parse(url)
      rescue => e
        puts e.message
        puts url
        next
      end
      last_entry = Video.where(channel: feed.title).order(:published_at).last
      feed.entries.each do |entry|
        next if last_entry && last_entry.published_at >= entry.published.localtime
        begin
          video = Video.youtube_new(feed, entry)
          video.set_tag
          video.save!
          video_count += 1
        rescue => e
          puts "error: #{feed.title}, #{entry.title}, #{entry.links.first}"
          puts e.message
        end
      end
    end
    puts "end rss:from_youtube! Add #{video_count} videos!!"
  end
end
