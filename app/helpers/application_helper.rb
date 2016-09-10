module ApplicationHelper

  def meta_tag_title
    title = ""
    num = Random.rand(1..3)
    words = Global.meta_data.words.sample(num)

    words.each_with_index do |word, i|
      title << word
      if i == (num - 1)
        title << "グラビア動画"
      else
        title << "、"
      end
    end

    title
  end

  def meta_tag_description(word = nil)
    if word
      <<-"EOS"
        人気グラビアアイドルのおすすめ動画をまとめているグラビアBOX動画。
        #{word}動画たくさん取り揃えています。
      EOS
    else
      words = Global.meta_data.words.sample(5)
      <<-"EOS"
        人気グラビアアイドルのおすすめ動画をまとめているグラビアBOX動画。
        #{words[0]}、#{words[1]}、#{words[2]}アイドルや#{words[3]}、#{words[4]}
        アイドルなど幅広く掲載しています。
      EOS
    end
  end
end
