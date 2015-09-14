class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  validates :topik,  presence: true, length: { maximum: 150}
  validates :content,  presence: true, length: { maximum: 10000}
  validates :user_id,  presence: true
end
