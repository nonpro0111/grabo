module Tag
  extend ActiveSupport::Concern

  def get_tag_name(text)
    natto = Natto::MeCab.new
    names = {}
    natto.parse(text) do |n|
      case n.feature
      when /人名,名/
        names[:first_name] = n.surface
      when /人名,姓/
        names[:last_name] = n.surface
      end

      break if names[:last_name] && names[:first_name]
    end
    puts "#{names[:last_name]}#{names[:first_name]}"
    "#{names[:last_name]}#{names[:first_name]}"
  end
end
