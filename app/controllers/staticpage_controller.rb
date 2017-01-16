class StaticpageController < ApplicationController
  def index
    if user_signed_in?
      redirect_to controller: :yamalogs, action: :index and return
    end

    @yamalogs = Yamalog.all
    render :layout => 'home_layout'
  end

  def help
  end

  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
