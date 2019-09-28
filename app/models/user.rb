# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions

  # Имя не не более 35 символов
  validates :name, presence: true, length: { maximum: 35 }

  validates :email, uniqueness: true

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end
end
