class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_user_name
  layout "mailer"
end
