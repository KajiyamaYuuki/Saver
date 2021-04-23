class StaffsController < ApplicationController
  before_action :ensure_shop_owner, only: %i[ new create edit update destroy ]
  before_action :set_staff, only: %i[ edit update destroy ]
  before_action :ensure_my_shop_owner, only: %i[ edit update destroy ]

  def index
    @staffs = Staff.all
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = current_user.shop.staffs.build(staff_params)
    if @staff.save
      redirect_to shop_path(current_user.shop.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      redirect_to shop_path(current_user.shop.id)
    else
      render :edit
    end
  end

  def destroy
    @staff.destroy
    redirect_to shop_path(current_user.shop.id)
  end

  private
  def staff_params
    params.require(:staff).permit(:name, :description, :image, :role, :sex, :work_history)
  end

  def ensure_my_shop_owner
    if current_user.present?
      unless current_user.id == @staff.shop.user_id
        flash[:notice] = '権限がありません'
        redirect_to shops_path
      end
    else
      flash[:notice] = '権限がありません'
      redirect_to shops_path
    end
  end

  def set_staff
    @staff = Staff.find(params[:id])
  end

end
