# frozen_string_literal: true

class SendEmailSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(event, subscription)
    EventMailer.subscription(event, subscription).deliver_later
  end
end
