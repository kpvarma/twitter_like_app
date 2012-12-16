class Tweet < ActiveRecord::Base
  
  attr_accessible :message, :private
  
  validates :message, :presence=>true, :length => {:maximum => 160}
  validates :user_id, :presence=>true
  
  belongs_to :user

end
