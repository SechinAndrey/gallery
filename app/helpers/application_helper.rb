module ApplicationHelper

  def greeting
    user_signed_in? ? "Hello #{current_user.email}" : "Hello Guest"
  end

end
