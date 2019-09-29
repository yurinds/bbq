# frozen_string_literal: true

class SendEmailSubscriptionJob < ApplicationJob
  queue_as :default

  # создаю отдельное задание на каждый тип отправки писем.
  # другого решения не нашел.
  # нужно спросить как правильно сделать...
  def perform(event, subscription)
    EventMailer.subscription(event, subscription).deliver_later
  end
end
