class PropertyApprovalMailer < ApplicationMailer
  def property_approved(property)
    @property = property
    user = User.find_by(id: property.user_id)
    if user && property.is_property_live
      # Send mail to only the user when property is approved
      mail(to: user.email, subject: 'Property Approved on AlveoHive')
    end
  end

  def property_submitted_for_review(property)
    @property = property
    user = User.find_by(id: property.user_id)
    if user
      # Send mail to both the user and AlveoHive support when property is submitted
      #recipients = [property.user.email.to_s, 'support@alveohive.com']
      mail(to: user.email, subject: 'Property Submitted for Review on AlveoHive')
    end
  end
end
