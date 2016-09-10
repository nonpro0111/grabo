module Admin
  class ApplicationController < ActionController::Base
    before_action :login_check
    before_action :authenticate_user!

    def login_check
      redirect_to new_user_session_path and return unless user_signed_in?
    end
  end
end
