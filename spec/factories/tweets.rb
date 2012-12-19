FactoryGirl.define do
  factory :tweet do |t|
    t.message { Faker::Lorem.paragraphs.first[0..159] }
    t.private { [false, true].sample }
    t.association :user
    #t.user User.select("id").all.sort_by{ rand }.first || User.new
  end
end
