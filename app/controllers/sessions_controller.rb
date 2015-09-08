class SessionsController < Devise::SessionsController
  skip_before_action :limitation_without_confirmation, only: [:destroy, :new]

  def new
    super
  end

  def destroy
    super
  end
end