# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    association :user

    title { "Событие_#{rand(999)}" }
    description { "Всем быть_#{rand(999)}" }
    address { "Москва_#{rand(999)}" }
    datetime { Time.parse('2019.10.19, 13:00') }
  end
end
