class PropertyApprovalMailer < ApplicationMailer
  def property_approved(property)
    @property = property
    # send mail to only the user when property is approved
    mail(to: property.user.email, subject: 'Property Approved on AlveoHive') do |format|
      format.text
    end
  end

  def property_submitted_for_review(property)
    @property = property
    # send mail to both the user and alveohive support when property is submitted
    #recipients = [property.user.email.to_s, 'support@alveohive.com']
    mail(to: property.user.email, subject: 'Property Submitted for Review on AlveoHive') do |format|
      format.text
    end
  end
end