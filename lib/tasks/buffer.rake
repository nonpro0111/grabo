namespace :buffer do
  desc "bufferに動画を配信"
  task :create => :environment do
    client = Buffer::Client.new(ENV['BUFFER_ACCESS_TOKEN'])
    profile_ids = ENV['BUFFER_PROFILE_ID']

    tag = ActsAsTaggableOn::Tag.most_used(100).sample
    video = Video.tagged_with(tag.name).sample
    text = <<-"EOS"
      #{video.title}。めちゃカワイイ#{tag.name}ちゃん！！ #グラビア動画 ##{tag.name}
      #{Global.settings.site.url}/videos/#{video.id}
    EOS

    response = client.create_update(body: { text: text, profile_ids: profile_ids, now: true })

    unless response["success"]
      Rails.logger.error(response)
    end
  end
end
