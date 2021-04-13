class StaffsController < ApplicationController
  before_action :ensure_shop_owner, only: %i[ new create edit update destroy ]

  def index
    @staffs = Staff.all
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = current_user.staffs.build(staff_params)
    if @staff.save
      redirect_to shop_path(@shop.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      redirect_to shop_path(@shop.id)
    else
      render :edit
    end
  end

  def destroy
    @staff.destroy
    redirect_to shop_path(@shop.id)
  end

  private
  def staff_params
    params.require(:staff).permit(:name, :description, :image, :role, :sex, :work_history)
  end

  def set_staff
    @shop = Staff.find(params[:id])
  end

  def ensure_shop_owner
    unless current_user.is_owner?
      flash[:notice] = '権限がありません'
      redirect_to shops_path
    end
  end

end
