module ApplicationHelper

  def greeting
    if user_signed_in?
      return current_user.name == "" ? "Hello #{current_user.username}" : "Hello #{current_user.name}"
    else
      return "Hello Guest"
    end
  end

  def mini_avatar
    if user_signed_in?
      if current_user.image_url(:thumb).to_s == ""
        return  image_tag("avatar.png", size: "50x50", alt: "Avatar")
      else
        return image_tag current_user.image_url(:thumb).to_s
      end
    end
  end

end