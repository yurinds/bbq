# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte]

  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :identities, dependent: :destroy

  # Имя не не более 35 символов
  validates :name, presence: true, length: { maximum: 35 }

  validates :email, uniqueness: true

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_or_create_by_omniauth(params)
    provider = params[:provider]
    url = params[:url]
    email = params[:email]

    user_identity = Identity.find_identity(url, provider)

    return user_identity.user if user_identity.present?

    return nil unless email

    user = where(email: email).first

    if user.present?
      user.identities.create!(url: url, provider: provider)

      return user
    end

    User.transaction do
      user = User.create!(
        name: params[:name] || "Товарисч #{rand(999)}",
        email: email,
        password: Devise.friendly_token.first(16)
      )
      user.identities.create!(url: url, provider: provider)
    rescue StandardError
      return nil
    end

    user
  end
end
