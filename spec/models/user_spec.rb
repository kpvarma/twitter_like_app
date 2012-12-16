# Reference: http://www.lukeredpath.co.uk/blog/developing-a-rails-model-using-bdd-and-rspec-part-1.html
require 'spec_helper'

describe User do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  
  it "should be valid" do
    @user.should be_valid
  end

  it "should create a new instance given a valid attribute" do
    @user.save!
  end
    
  describe "email" do
    
    it "should require an email address" do
      blank_email_user = @user
      blank_email_user.email = ""
      blank_email_user.should_not be_valid

      nil_email_user = @user
      nil_email_user.email = nil
      nil_email_user.should_not be_valid
    end
  
    it "should accept valid email addresses" do
      emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      emails.each do |email|
        valid_email_user = @user
        valid_email_user.email = email
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      emails.each do |email|
        invalid_email_user = @user
        invalid_email_user.email = email
        invalid_email_user.should_not be_valid
      end
    end

    it "should reject duplicate email addresses" do
      saved_user = FactoryGirl.create(:user)
      user_with_duplicate_email = @user
      user_with_duplicate_email.email = saved_user.email
      user_with_duplicate_email.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
      saved_user = FactoryGirl.create(:user)
      user_with_duplicate_email = @user
      user_with_duplicate_email.email = saved_user.email.upcase
      user_with_duplicate_email.should_not be_valid
    end
  end
  
  describe "username" do
    
    it "should require a username" do
      blank_username_user = @user
      blank_username_user.username = ""
      blank_username_user.should_not be_valid
      
      nil_username_user = @user
      nil_username_user.username = nil
      nil_username_user.should_not be_valid
    end
    
    ## 6 - 12 characters among - a-z, A-Z, 1-9
    it "should accept valid usernames" do
      usernames = %w[1234567 abcdefg ABCDEFG ABCdef123 kp-varma]
      usernames.each do |username|
        valid_username_user = @user
        valid_username_user.username = username
        valid_username_user.should be_valid
      end
    end

    it "should reject invalid usernames" do
      usernames = %w[123 asd abcdef#1233@ abcd123@ JP0!12@34A]
      usernames.each do |username|
        invalid_username_user = @user
        invalid_username_user.username = username
        invalid_username_user.valid?
        invalid_username_user.should_not be_valid
      end
    end

    it "should reject duplicate usernames" do
      saved_user = FactoryGirl.create(:user)
      user_with_duplicate_username = @user
      user_with_duplicate_username.username = saved_user.username
      user_with_duplicate_username.should_not be_valid
    end

    it "should reject usernames identical up to case" do
      saved_user = FactoryGirl.create(:user)
      user_with_duplicate_username = @user
      user_with_duplicate_username.username = saved_user.username.upcase
      user_with_duplicate_username.should_not be_valid
    end
     
  end
  
  describe "name" do 
    
    it "should require a name" do
      blank_name_user = @user
      blank_name_user.name = ""
      blank_name_user.should_not be_valid

      nil_name_user = @user
      nil_name_user.name = nil
      nil_name_user.should_not be_valid
    end
    
    ## 3 - 12 characters -[ a-z, A-Z, <space> and . ]
    it "should accept valid names" do
      names = ["Krishnaprasad Varma" "K.P.Varma" "KPVarma" "K P Varma"]
      names.each do |name|
        valid_name_user = @user
        valid_name_user.name = name
        valid_name_user.should be_valid
      end
    end
    
    it "should accept invalid names" do
      names = ["Krishnaprasad123" "K-P Varma" "KPVarma$" "kp varma 12"]
      names.each do |name|
        valid_name_user = @user
        valid_name_user.name = name
        valid_name_user.should_not be_valid
      end
    end
    
  end
  
  describe "passwords" do

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      @user.password = ""
      @user.password_confirmation = ""
      @user.should_not be_valid
    end

    it "should require a matching password confirmation" do
      @user.password = "matched"
      @user.password_confirmation = "unmatched"
      @user.should_not be_valid
    end

    it "should reject short passwords" do
      @user.password = "a"*5
      @user.password_confirmation = "a"*5
      @user.should_not be_valid
    end

    it "should reject long passwords" do
      @user.password = "a"*41
      @user.password_confirmation = "a"*41
      @user.should_not be_valid
    end

  end

  describe "password encryption" do

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

end