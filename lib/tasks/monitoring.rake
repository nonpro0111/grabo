namespace :monitoring do
  desc "banされた動画データを削除する"
  task :delete_banned_video => :environment do
    puts "monitoring start at #{Time.current}"
    Video.find_each do |video|
      if video.banned?
        puts "delete id: #{video.id}, url: #{video.url}"
        video.delete
      end
    end
    puts "monitoring end"
    puts "refresh sitemap start"
    Rake::Task["sitemap:refresh"].execute
    puts "refresh sitemap end"
  end
end
