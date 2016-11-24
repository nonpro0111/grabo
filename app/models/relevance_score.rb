class RelevanceScore < ActiveRecord::Base
  class << self
    def update_or_create_data(referer_id, request_id)
      return if referer_id == request_id

      statistic_data = find_or_create_by(referer_tag_id: referer_id, request_tag_id: request_id)
      statistic_data.increment!(:appearance_count)
    end
  end
end
