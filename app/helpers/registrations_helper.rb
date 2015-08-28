module RegistrationsHelper

  def reg_name
   return $temp_user.nil? ? "" : $temp_user.info.name.to_s

  end

  def reg_email
    if $temp_user.nil?
      return ""
    else
      email = "#{$temp_user[:provider]}@#{$temp_user.info.name.delete(' ')}.com"
      $temp_user = nil
      return email
    end
  end

end
