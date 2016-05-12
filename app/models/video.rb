require 'net/http'
class Video < ActiveRecord::Base
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス

  def banned?
    uri = URI.parse(URI.escape(thumbnail))
    Net::HTTP.get_response(uri).code == '404'
  end
end
