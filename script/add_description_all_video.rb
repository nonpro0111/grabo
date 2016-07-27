def main
  Video.all.each do |video|
    video.add_one_word
    video.save
  end
end

main
