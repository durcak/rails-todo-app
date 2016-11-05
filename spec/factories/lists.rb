FactoryGirl.define do
  factory :list do
    sequence :name do |n|
      "List #{n}"
    end

    sequence :description do |n|
      "Description #{n}"
    end
  end
end
