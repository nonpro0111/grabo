namespace :rss do
  desc "youtube rss 取得"
  task :create_video => :environment do
    sites = %w(youtube fc2)
    sites.each do |site|
      Global.feeds.send(site).each do |url|
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
            video = Video.new(
              title: entry.video_title,
              thumbnail: entry.video_thumbnail,
              original_site: site,
              embed_code: entry.video_embed_code,
              published_at: entry.published,
              channel: feed.title,
              url: entry.video_url,
              description: entry.video_description
            )
            video.set_tag
            video.save!
          rescue
          end
        end
      end
    end
  end

 # desc "niconico rss 取得"
 # task :from_niconico => :environment do
 #   puts "start"
 #   video_count = 0
 #   Global.idols.nico_list.each do |idol|
 #     url = URI.encode("http://www.nicovideo.jp/tag/#{idol}?sort=f&rss=2.0")
 #     begin
 #       feed = Feedjira::Feed.fetch_and_parse(url)
 #     rescue => e
 #       puts e.message
 #       next
 #     end
 #     last_entry = Video.where(channel: feed.title).order(:published_at).last
 #     feed.entries.each do |entry|
 #       next if last_entry && last_entry.published_at >= entry.published.localtime
 #       begin
 #         video = Video.niconico_new(feed, entry)
 #         video.tag_list.add(idol)
 #         video.save!
 #         video_count += 1
 #       rescue => e
 #         puts "#{e.message}\n#{feed.title}, #{entry.title}, #{entry.url}"
 #       end
 #     end
 #   end
 #   puts "Add #{video_count} videos!!"
 # end
end
