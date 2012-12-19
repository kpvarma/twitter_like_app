FactoryGirl.define do
  factory :following do |f|
    f.association :user
    f.association :follower
    #f.user User.all.sort_by{ rand }.first || User.new
    #f.follower User.all.sort_by{ rand }.first || User.new
  end
end
