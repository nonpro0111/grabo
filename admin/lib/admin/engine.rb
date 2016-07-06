require 'devise'
module Admin
  class Engine < ::Rails::Engine
    isolate_namespace Admin

    config.to_prepare do
      Devise::SessionsController.layout "admin/application"
    end
  end
end
