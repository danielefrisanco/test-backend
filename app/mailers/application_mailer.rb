# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'daniele@frisanco.com'
  layout 'mailer'
end
