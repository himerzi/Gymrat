class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def only_if_admin
    redirect_to root_url if !current_user.try(:admin?)
  end
  def current_user?
    redirect_to root_url, :notice => "You must be logged in to do this !" unless current_user
  end
end
