namespace :buffer do
  desc "bufferに動画を配信"
  task :create_video => :environment do
    client = Buffer::Client.new(Rails.application.secrets.buffer_access_token)
    profile_ids = Rails.application.secrets.buffer_profile_id

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

  desc "bufferにdmm広告追加"
  task :create_dmm_ad => :environment do
    buffer_client = Buffer::Client.new(Rails.application.secrets.buffer_access_token)
    profile_ids = Rails.application.secrets.buffer_profile_id
    dmm_client = DMM.new(
      api_id: Rails.application.secrets.dmm_api_id, 
      affiliate_id: Rails.application.secrets.dmm_afi_id
    )

    ad = dmm_client.product(site: 'DMM.com', service: 'digital', floor: 'idol',
                            sort: 'rank', hits: 100).result[:items].sample

    idol = ad[:iteminfo][:actor].first[:name]
    media = { photo: ad[:imageURL][:large], link: ad[:affiliateURL] }
    text = "#{ad[:title]}、ギリギリショット！ #グラビアアイドル ##{idol} #{ad[:affiliateURL]}"

    response = buffer_client.create_update(body:{ text: text, profile_ids: profile_ids, media: media, now: true })

    unless response["success"]
      Rails.logger.error(response)
    end
  end

  # お試し、不要なら消す
  desc "bufferにdmmアダルト広告追加"
  task :create_dmm_adult_ad => :environment do
    buffer_client = Buffer::Client.new(Rails.application.secrets.buffer_access_token)
    profile_ids = Rails.application.secrets.buffer_profile_id
    dmm_client = DMM.new(
      api_id: Rails.application.secrets.dmm_api_id, 
      affiliate_id: Rails.application.secrets.dmm_afi_id
    )

    ad = dmm_client.product(site: 'DMM.R18', service: 'digital', keyword: 'グラビア',
                            sort: 'date', hits: 100).result[:items].sample
    actress = ad[:iteminfo][:actress].first[:name]
    media = { photo: ad[:imageURL][:large], link: ad[:affiliateURLsp] }
    text = " 【グラドルのAV】#{ad[:title]}、抜けすぎちゃうんだよな〜！#グラビアアイドル #AV ##{actress} #{ad[:affiliateURLsp]}"

    response = buffer_client.create_update(body:{ text: text, profile_ids: profile_ids, media: media, now: true })

    unless response["success"]
      Rails.logger.error(response)
    end
  end
end
