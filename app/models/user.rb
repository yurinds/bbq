# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events
  # Имя не не более 35 символов
  validates :name, presence: true, length: { maximum: 35 }
  # Уникальный email по заданному шаблону не более 255
  # символов
  validates :email, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@(([-[:word:]]+\.)+[[:word:]]{2,})\z/,
                              message: 'is not an email' }
end
