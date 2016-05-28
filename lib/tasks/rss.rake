namespace :rss do
  desc "youtube rss 取得"
  task :from_youtube => :environment do
    puts "start"
    video_count = 0 
    Global.feeds.youtube.each do |url|
      begin
        feed = Feedjira::Feed.fetch_and_parse(url)
      rescue => e
        puts e.message
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
          puts "#{e.message}\n#{feed.title}, #{entry.title}, #{entry.links.first}"
        end
      end
    end
    puts "Add #{video_count} videos!!"
  end

  desc "fc2 rss 取得"
  task :from_fc2 => :environment do
    puts "start"
    video_count = 0
    Global.feeds.fc2.each do |url|
      begin
        feed = Feedjira::Feed.fetch_and_parse(url)
      rescue => e
        puts e.message
        next
      end
      last_entry = Video.where(channel: feed.title).order(:published_at).last
      feed.entries.each do |entry|
        next if last_entry && last_entry.published_at >= entry.published.localtime
        begin
          video = Video.fc2_new(feed, entry)
          video.set_tag
          video.save!
          video_count += 1
        rescue => e
          puts "#{e.message}\n#{feed.title}, #{entry.title}, #{entry.url}"
        end
      end
    end
    puts "Add #{video_count} videos!!"
  end
end
