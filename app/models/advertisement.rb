class Advertisement < ActiveRecord::Base
  mount_uploader :image, AdImageUploader
end
