class DriversController < ApplicationController
  before_action :set_driver, only: [:show,:edit,:update,:destroy, :dash]
  before_action :require_user, except: [:index, :show, :new, :create, :dash]
  before_action :require_same_user,only: [:edit, :update, :dash]
  before_action :require_admin, only: [:destroy]
  def new
    @driver = Driver.new
  end
  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      flash[:success] = "Welcome #{@driver.name} to RotaMate"
      session[:driver_id] = @driver.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  def index
    @drivers = Driver.paginate(page: params[:page], per_page: 10)
  end
  def show
    @driver_duties = @driver.duties.paginate(page: params[:page], per_page: 5)
  end
  def edit
  end
  def update
    if @driver.update(driver_params)
      flash[:success] = "Your account was was successfully updated"
      redirect_to driver_path(@driver)
    else
      render 'edit'
    end
  end
  def destroy
    if !@driver.admin?
      @driver.destroy
      flash[:danger] = "Driver and all associated duties have been deleted"
      redirect_to drivers_path
    end
  end
  def dash
    if params[:start_date] != nil
      @driver_duties = @driver.duties.where("start_date >= ? AND start_date <= ? ", Date.parse(params[:start_date]) - 1.months, Date.parse(params[:start_date]) + 1.months)
    else 
      @driver_duties = @driver.duties.where("start_date >= ? AND start_date <= ? ", Date.today - 1.months, Date.today + 1.months)
    end
  end
  private
    def set_driver
      @driver = Driver.find(params[:id])
    end
    def driver_params
      params.require(:driver).permit(:name, :email, :password, :password_confirmation)
    end
    def require_same_user
      if current_driver != @driver and !current_driver.admin
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to drivers_path
      end
    end
    def require_admin
      if logged_in? && !current_driver.admin?
        flash[:danger] = "Only Admins can perform that action"
        redirect_to root_path
      end
    end
end
