class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :authentication_keys => [:login]

  attr_accessible :name, :username, :email, :password, :password_confirmation, :remember_me, :login
  attr_accessor :login
  
  ## Validations
  validates :username, :presence=>true, :length => {:minimum => 4 ,:maximum => 56}, :uniqueness => {:case_sensitive => false}
  validates_format_of :username, :with => /^[a-zA-Z1-9\-+]*$/i
  validates :name, :presence=>true, :length => {:minimum => 3 ,:maximum => 56}
  validates_format_of :name, :with => /^[a-zA-Z\s\\.+]*$/i 
  validates_format_of :password, :with => /^[a-zA-Z1-9+\\!\\@\\#\\$\\&\\*\\_+]*$/i 
  
  has_many :tweets
  has_many :retweets
  
  ## List of Users to which i am subscribed to. I am following them.
  has_many :friend_followings, :class_name=>'Following', :foreign_key => 'follower_id'
  has_many :friends, :through => :friend_followings, :source => :user
  
  ## List of Users who are subscribed to me. They are following me.
  has_many :followed_users, :class_name => 'Following', :foreign_key => 'user_id'
  has_many :followers, :through => :followed_users, :source => :follower
  
  # a.is_following(b) will return true if a is following b.
  def is_following?(user)
    following = Following.where({:user_id=>user.id, :follower_id=>id}).first
    return following ? true : false 
  end
  
  def can_retweet?(tweet)
    
    return false if self == tweet.user
    
    if tweet.private?
      if self.is_following?(tweet.user)
        return true
      else
        return false
      end
    else
      return true
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
