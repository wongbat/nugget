require 'factory_girl'

FactoryGirl.define do
  factory :user do |f|
    f.name "Mog"
    f.email "mog@hotmail.com"
  end

  factory :invalid_user, parent: :user do |f|
    f.name nil
    f.email nil
  end
end
