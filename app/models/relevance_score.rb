class RelevanceScore < ActiveRecord::Base
  class << self
    def update_or_create_score(referer_idol_id, request_idol_ids)
      request_idol_ids.reject! { |id| id == referer_idol_id }

      request_idol_ids.each do |request_idol_id|
         score = find_or_create_by(
                   referer_idol_id: referer_idol_id,
                   request_idol_id: request_idol_id
                 )
         score.increment!(:appearance_count)
      end
    end
  end
end
