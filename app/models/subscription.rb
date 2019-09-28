# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id,
                                 message: I18n.t('subscription.already_subscribed') },
                   if: -> { user.present? }
  validate :user_cannot_subscribe_to_his_event

  validate :email_cannot_belong_to_registred_user, unless: -> { user.present? }
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

  def user_cannot_subscribe_to_his_event
    # нельзя подписываться на свои события
    if user.present? && user == event.user
      errors.add(:user, I18n.t('subscription.user_absence'))
    end
  end

  def email_cannot_belong_to_registred_user
    if User.where(email: user_email).present?
      errors.add(:user_email, I18n.t('subscription.email_cannot_belong_to_user'))
    end
  end
end
