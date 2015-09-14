class IdentitiesController < ApplicationController
  def destroy
      Identity.find(params[:id]).destroy
      redirect_to edit_user_registration_path
    end
end

