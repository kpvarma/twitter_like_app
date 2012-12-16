require 'factory_girl'

FactoryGirl.define do
  #sequence(:email) {|n| "user-#{n}@testingapp.com" }
  #sequence(:name) {|n| "User Name #{n}" }
  #sequence(:username) {|n| "username#{n}" }

  factory :user do |u|
    u.name {"#{Faker::Name::first_name} #{Faker::Name::last_name}"}
    u.username {|u| "#{u.name.gsub(" ","-").downcase.strip}" }
    u.email {|u| "#{u.username}@example.com" }
    u.password "itsasecret"
  end
end

