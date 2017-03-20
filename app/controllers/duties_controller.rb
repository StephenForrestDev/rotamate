class DutiesController < ApplicationController
  def index
    @duties = Duty.all
  end
  def new
    @duty = Duty.new
  end
  def create
    @duty = Duty.new(duty_params)
    @duty.driver = Driver.first
    if @duty.save
      flash[:success] = "Duty was created successfully"
      redirect_to duty_path(@duty)
    else
      render 'new'
    end
  end
  def show
    @duty = Duty.find(params[:id])
  end
  def edit
    @duty = Duty.find(params[:id])
  end
  def update
    @duty = Duty.find(params[:id])
    if @duty.update(duty_params)
      flash[:success] = "Duty was successfully updated"
      redirect_to duty_path(@duty)
    else
      render 'edit'
    end
  end
  def destroy
    @duty = Duty.find(params[:id])
    @duty.destroy
    flash[:success] = "Duty was successfully destroyed"
    redirect_to duties_path
  end
  private
    def duty_params
      params.require(:duty).permit(:dutynum, :starttime, :endtime, :paytime,:notes)
    end
end