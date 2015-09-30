module ApplicationHelper

  def greeting
    if user_signed_in?
      return current_user.name == "" ? "#{t 'layouts._header.lb_hello' } #{current_user.username}" : "#{t 'layouts._header.lb_hello' } #{current_user.name}"
    else
      return "#{t 'layouts._header.lb_hello_guest' }"
    end
  end

  def mini_avatar
    if user_signed_in?
      if current_user.image.thumb.blank? || !current_user.image.thumb.file.exists?
        image_tag("avatar.png", size: "50x50", alt: "Avatar")
      else
        image_tag("#{current_user.image_url(:thumb)}", class: "img-circle")
      end
    end
  end


end