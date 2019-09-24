# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id,
                                 message: I18n.t('subscription.already_subscribed') },
                   if: -> { user.present? }
  validates :user, absence: { message: I18n.t('subscription.user_absence') },
                   if: -> { user.present? && user == event.user }

  validate :email_cannot_belong_to_user, unless: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def email_cannot_belong_to_user
    if User.where(email: user_email).present?
      errors.add(:user_email, I18n.t('subscription.email_cannot_belong_to_user'))
    end
  end
end
