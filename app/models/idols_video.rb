class IdolsVideo < ActiveRecord::Base
  belongs_to :idol
  belongs_to :video
end
