class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :vkontakte]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.#{user.provider}_data"] && session["devise.#{user.provider}_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    $temp_user = auth
    where(provider: auth.provider, uid: auth.uid).first #do |user|
     # user.email = "#{auth[:provider]}@#{auth.info.name.delete(' ')}.com"
     # user.password = Devise.friendly_token[0,20]
     # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
   # end
  end

end