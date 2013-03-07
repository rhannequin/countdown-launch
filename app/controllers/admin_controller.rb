class AdminController < ApplicationController
  protect_from_forgery

  before_filter :only_logged, :except => [:login, :authenticate]

  def index
    @ctdowns = Ctdown.all
  end

  def destroy
    ctdown = Ctdown.find params[:id]
    ctdown.destroy
    redirect_to admin_path
  end

  def login
    redirect_to admin_path if is_logged?
  end

  def authenticate
    return redirect_to admin_path if is_logged?
    user = params[:user]
    if user[:login] === ENV['ADMIN_LOGIN'] and user[:password] === ENV['ADMIN_PASSWORD']
      connect
      redirect_to admin_path, flash: { success: 'Welcome!' }
    else
      redirect_to admin_login_path, flash: { error: 'Sorry, these are wrong information.' }
    end
  end
end