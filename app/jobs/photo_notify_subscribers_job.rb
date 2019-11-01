# frozen_string_literal: true

class PhotoNotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(event, photo)
    emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user.email]).uniq

    emails.each do |mail|
      EventMailer.photo(event, photo, mail).deliver_later
    end
  end
end
