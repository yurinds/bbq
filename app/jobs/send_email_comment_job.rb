# frozen_string_literal: true

class SendEmailCommentJob < ApplicationJob
  queue_as :default

  # создаю отдельное задание на каждый тип отправки писем.
  # другого решения не нашел.
  # нужно спросить как правильно сделать...
  def perform(event, comment, mail)
    EventMailer.comment(event, comment, mail).deliver_later
  end
end
