class PropertyApprovalMailer < ApplicationMailer
  def property_approved(property)
    @property = property
    user = User.find_by(id: property.user_id)
    if user && property.is_property_live
      attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/alveohive-logo-full-color2.png'))
      mail(to: user.email, subject: 'Property Approved on AlveoHive') do |format|
        format.html
        format.text
      end
    end
  end

  def property_submitted_for_review(property)
    @property = property
    user = User.find_by(id: property.user_id)
    if user
      attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/alveohive-logo-full-color2.png'))
      mail(to: user.email, subject: 'Property Submitted for Review on AlveoHive') do |format|
        format.html
        format.text
      end
    end
  end
end
