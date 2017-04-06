class PagesController < ApplicationController
  def home
    redirect_to dashboard_path(current_driver.id) if logged_in?
  end
end
