require 'net/http'
class Video < ActiveRecord::Base

  def banned?
    uri = URI.parse(URI.escape(thumbnail))
    Net::HTTP.get_response(uri).code == '404'
  end
end
