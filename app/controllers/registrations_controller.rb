class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
    #resource.send_confirmation_instructions
    sign_in(resource)

  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :username, :image)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :username, :image)
  end
end