# frozen_string_literal: true

class SendEmailPhotoJob < ApplicationJob
  queue_as :default

  # создаю отдельное задание на каждый тип отправки писем.
  # другого решения не нашел.
  # нужно спросить как правильно сделать...
  def perform(event, photo, mail)
    EventMailer.photo(event, photo, mail).deliver_later
  end
end
