class DutiesController < ApplicationController
  before_action :set_duty, only: [:show,:edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user,only: [:edit, :update, :destroy]
  def index
    @duties = Duty.order(:dutynum).where("dutynum like ?", "%#{params[:term]}%")
    render json: @duties.map(&:dutynum)
  end
  def get_json
    duty = Duty.find(params[:id])
    render :text => duty.to_json
  end
  def new
    @duty = Duty.new
    @initial_date = params[:initial_date]
    @existing_duties = Duty.group(:dutynum)
  end
  def create
    @duty = Duty.new(duty_params)
    @duty.driver = current_driver
    if @duty.save
      flash[:success] = "Duty was created successfully"
      redirect_to duty_path(@duty)
    else
      render 'new'
    end
  end
  def show
    
  end
  def edit
    
  end
  def update
    if @duty.update(duty_params)
      flash[:success] = "Duty was successfully updated"
      redirect_to duty_path(@duty)
    else
      render 'edit'
    end
  end
  def destroy
    @duty.destroy
    flash[:success] = "Duty was successfully destroyed"
    redirect_to duties_path
  end
  private
    def set_duty
      @duty = Duty.find(params[:id])
    end
    def duty_params
      params.require(:duty).permit(:dutynum, :starttime, :endtime, :paytime,:notes, :start_date)
    end
    def require_same_user
      if current_driver != @duty.driver and !current_driver.admin?
        flash[:danger] = "You can only edit or delete your own duties"
        redirect_to duties_path
      end
    end
end