class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_shop_owner
    if current_user.present?
      unless current_user.is_owner?
        flash[:notice] = '権限がありません'
        redirect_to shops_path
      end
    else
      flash[:notice] = '権限がありません'
      redirect_to shops_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
  end
end
