# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'bbq-friends@gmail.com'
  layout 'mailer'
end
