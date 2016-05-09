namespace :monitoring do
  desc "banされた動画データを削除する"
  task :delete_banned_video => :environment do
    Video.find_each do |video|
      if video.banned?
        puts "delete id: #{video.id}, url: #{video.url}"
        video.delete
      end
    end
  end
end
