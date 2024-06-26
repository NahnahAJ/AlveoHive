class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_USERNAME'] || "support@alveohive.com"
  layout "mailer"
end
