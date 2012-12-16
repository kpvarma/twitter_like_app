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
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
