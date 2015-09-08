class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

  def self.unbound_acc(provider, id)
    self.find_by(provider: provider, user_id: id).destroy
  end

  def self.acc(provider, id)
    find_by(provider: provider, user_id: id).nil? ? false : true
  end
end
