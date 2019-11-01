# frozen_string_literal: true

class CommentNotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(event, comment, user)
    emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [user&.email]).uniq

    emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_later
    end
  end
end
