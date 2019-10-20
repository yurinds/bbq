# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@many-events.ru'
  layout 'mailer'
end
