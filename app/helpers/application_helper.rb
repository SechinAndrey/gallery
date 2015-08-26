module ApplicationHelper

  def greeting
    user_signed_in? ? "Hello #{current_user.name}" : "Hello Guest"
  end

end
