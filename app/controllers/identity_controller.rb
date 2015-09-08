class IdentityController < ApplicationController
  def destroy
    if current_user.id.to_i == params[:id].to_i
      Identity.unbound_acc(params[:provider], params[:id])
      redirect_to edit_user_registration_path
    end
  end
end
