require 'factory_bot'

FactoryBot.define do
  factory :client do
    sequence(:device_token) { SecureRandom.uuid }
  end

  factory :client_setting do
    association :client
    association :experiment
    association :experiment_option
  end

  factory :experiment do
    sequence(:name) { |n| "name_#{n}" }
  end

  factory :experiment_option do
    association :experiment
    sequence(:value) { |n| "value_#{n}" }
  end
end
