# frozen_string_literal: true

class CommentMailerJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :resque

  def perform(event, comment, mail)
    EventMailer.comment(event, comment, mail).deliver_now
  end
end
