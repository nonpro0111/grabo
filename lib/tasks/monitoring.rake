namespace :monitoring do
  desc "banされた動画データを削除する"
  task :delete_banned_video => :environment do
    puts "start monitoring at #{Time.current}"
    Video.find_each do |video|
      if video.banned?
        puts "delete id: #{video.id}, url: #{video.url}"
        video.delete
      end
    end
    puts "end monitoring"
  end
end
