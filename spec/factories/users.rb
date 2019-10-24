# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Товарисч_#{rand(999)}" }

    sequence(:email) { |n| "someguy_#{n}@example.com" }

    # коллбэк - после фазы :build записываем поля паролей, иначе Devise не позволит :create юзера
    after(:build) { |u| u.password_confirmation = u.password = '123456' }
  end
end
