class SessionsController < ApplicationController
  def new
    
  end
  def create 
    driver = Driver.find_by(email: params[:session][:email].downcase)
    if driver && driver.authenticate(params[:session][:password])
      session[:driver_id] = driver.id
      flash[:success] = "You have successfully logged in"
      redirect_to driver_path(driver)
    else
      flash.now[:danger] = "Incorrect email or password"
      render 'new'
    end
  end
  
  def destroy
    session[:driver_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
    
end