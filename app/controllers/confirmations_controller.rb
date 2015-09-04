class ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :limitation_without_confirmation

end