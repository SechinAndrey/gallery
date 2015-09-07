module ApplicationHelper

  def greeting
    if user_signed_in?
      return current_user.name == "" ? "Hello #{current_user.username}" : "Hello #{current_user.name}"
    else
      return "Hello Guest"
    end
  end

end