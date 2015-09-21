class Tag < ActiveRecord::Base
  has_many :post_tag, :dependent => :destroy
end
