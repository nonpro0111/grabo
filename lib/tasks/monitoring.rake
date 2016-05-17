namespace :monitoring do
  desc "banされた動画データを削除する"
  task :delete_banned_video => :environment do
    puts "monitoring start at #{Time.current}"
    Video.find_each do |video|
      if video.banned?
        puts "delete id: #{video.id}, url: #{video.url}"
        video.tag_list.clear
        video.delete
      end
    end
    puts "monitoring end"
  end

  desc "タグ追加"
  task :add_tag => :environment do
    Video.find_each do |video|
      next if video.tag_list.present?

      Global.idols.list.each do |idol|
        if video.title.index(idol)
          video.tag_list.add(idol)
        end
      end
    end
  end

end
