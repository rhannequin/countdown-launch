class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def connect
      session[:user] = 'logged'
    end
    helper_method :connect

    def only_logged
      redirect_to admin_login_path, flash: { error: 'You must be logged access to admin.' } unless is_logged?
    end

    def is_logged?
      !session[:user].nil? and session[:user] == 'logged'
    end
end
