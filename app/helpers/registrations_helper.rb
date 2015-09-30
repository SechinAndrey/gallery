module RegistrationsHelper

  def bounds_acc(provider)
    identity = Identity.acc(provider, resource.id)
    if !identity
      p link_to " #{t 'devise.registrations.edit.l_unbound'} #{provider.to_s.titleize}", omniauth_authorize_path(resource_name, provider)
    else
      p link_to " #{t 'devise.registrations.edit.l_bound'} #{provider.to_s.titleize}", identity, :method => :delete
    end
  end

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
