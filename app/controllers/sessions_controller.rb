class SessionsController < Devise::SessionsController
  skip_before_action :limitation_without_confirmation, only: [:destroy]

  def destroy
    super
  end
end