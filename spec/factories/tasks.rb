FactoryGirl.define do
  factory :task do
    sequence :name do |n|
      "Task #{n}"
    end

    priority 0

    list
  end
end
