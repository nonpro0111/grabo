class Advertisement < ActiveRecord::Base
  mount_uploader :image, Admin::AdImageUploader
end
