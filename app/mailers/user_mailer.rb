class UserMailer < ApplicationMailer
    default from: 'support@alveohive.com'
    before_action :add_inline_attachments!
  
    def reset_password_instructions(record, token, opts={})
      opts[:subject] ||= 'Reset password instructions'
      @token = token
      @resource = record
      mail(to: record.email, subject: opts[:subject])
    end
  
    private
  
    def add_inline_attachments!
      attachments.inline['alveohive-logo-full-color2.png'] = File.read(Rails.root.join('app/assets/images/alveohive-logo-full-color2.png'))
    end
  end
  