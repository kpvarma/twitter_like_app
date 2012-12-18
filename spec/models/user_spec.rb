require 'spec_helper'

describe User do
  
  it "should be valid" do
    @user = FactoryGirl.create(:user)
    @user.should be_valid
  end

  it "should create a new instance given a valid attribute" do
    @user = FactoryGirl.create(:user)
    @user.save!
  end
    
  describe "email" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should require an email address" do
      @user.email = ""
      @user.valid?
      @user.should be_invalid
      @user.should have(1).error_on(:email)

      @user.email = nil
      @user.valid?
      @user.should be_invalid
      @user.should have(1).error_on(:email)
    end
  
    it "should accept valid email addresses" do
      emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      emails.each do |email|
        @user.email = email
        @user.valid?
        @user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      emails.each do |email|
        @user.email = email
        @user.valid?
        @user.should be_invalid
        @user.should have(1).error_on(:email)
      end
    end

    it "should reject duplicate email addresses" do
      saved_user = FactoryGirl.create(:user)
      @user.email = saved_user.email
      @user.valid?
      @user.should be_invalid
      @user.should have(1).error_on(:email)
    end

    it "should reject email addresses identical up to case" do
      saved_user = FactoryGirl.create(:user)
      @user.email = saved_user.email.upcase
      @user.valid?
      @user.should be_invalid
      @user.should have(1).error_on(:email)
    end
  end
  
  describe "username" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should require a username" do
      @user.username = ""
      @user.valid?
      @user.should be_invalid
      @user.should have(2).error_on(:username)
      
      @user.username = nil
      @user.valid?
      @user.should be_invalid
      @user.should have(2).error_on(:username)
    end
    
    ## 6 - 12 characters among - a-z, A-Z, 1-9
    it "should accept valid usernames" do
      usernames = %w[1234567 abcdefg ABCDEFG ABCdef123 kp-varma]
      usernames.each do |username|
        @user.username = username
        @user.valid?
        @user.should be_valid
      end
    end

    it "should reject invalid usernames" do
      usernames = %w[123 asd abcdef#1233@ abcd123@ JP0!12@34A]
      usernames.each do |username|
        @user.username = username
        @user.valid?
        @user.should be_invalid
        @user.should have(1).error_on(:username)
      end
    end

    it "should reject duplicate usernames" do
      saved_user = FactoryGirl.create(:user)
      @user.username = saved_user.username
      @user.valid?
      @user.should be_invalid
      @user.should have(1).error_on(:username)
    end

    it "should reject usernames identical up to case" do
      saved_user = FactoryGirl.create(:user)
      @user.username = saved_user.username.upcase
      @user.valid?
      @user.should be_invalid
      @user.should have(1).error_on(:username)
    end
     
  end
  
  describe "name" do 
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should require a name" do
      @user.name = ""
      @user.valid?
      @user.should be_invalid
      @user.should have(2).error_on(:name)

      @user.name = nil
      @user.valid?
      @user.should be_invalid
      @user.should have(2).error_on(:name)
    end
    
    ## 3 - 12 characters -[ a-z, A-Z, <space> and . ]
    it "should accept valid names" do
      names = ["Krishnaprasad Varma" "K.P.Varma" "KPVarma" "K P Varma"]
      names.each do |name|
        @user.name = name
        @user.valid?
        @user.should be_valid
      end
    end
    
    it "should accept invalid names" do
      names = ["Krishnaprasad123" "K-P Varma" "KPVarma$" "kp varma 12"]
      names.each do |name|
        @user.name = name
        @user.valid?
        @user.should be_invalid
        @user.should have(1).error_on(:name)
      end
    end
    
  end
  
  describe "password validations" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should require a password" do
      @user.password = ""
      @user.password_confirmation = ""
      @user.should be_invalid
      @user.should have(1).error_on(:password)
    end

    it "should require a matching password confirmation" do
      @user.password = "matched"
      @user.password_confirmation = "unmatched"
      @user.should be_invalid
      @user.should have(1).error_on(:password)
    end

    it "should reject short passwords" do
      @user.password = "a"*5
      @user.password_confirmation = "a"*5
      @user.should be_invalid
      @user.should have(1).error_on(:password)
    end

    it "should reject long passwords" do
      @user.password = "a"*41
      @user.password_confirmation = "a"*41
      @user.should be_invalid
      @user.should have(1).error_on(:password)
    end

  end

  describe "password encryption" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

end