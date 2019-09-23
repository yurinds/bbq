# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :events
  has_many :comments, dependent: :destroy

  before_validation :set_name, on: :create

  # Имя не не более 35 символов
  validates :name, presence: true, length: { maximum: 35 }

  validates :email, uniqueness: true

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if name.blank?
  end
end
