require 'factory_girl'

FactoryGirl.define do
  factory :micropost do |f|
    f.association :user
    f.content "hello"
  end

  factory :invalid_micropost, parent: :micropost do |f|
    f.content "ABC"*140
  end
end