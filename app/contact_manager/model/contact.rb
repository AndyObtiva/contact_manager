require 'db/db'

class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: {with: /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i, message: 'must be a valid email address'}, allow_blank: true
  validates :phone, format: {with: /\A[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.\/0-9]*\z/, message: 'must be a valid phone number'}, allow_blank: true
  validate :email_or_phone_is_present
  
  def address
    [street, city, state_or_province, zip_or_postal_code, country].compact.join(', ')
  end
  
  private
  
  def email_or_phone_is_present
    if email.blank? && phone.blank?
      errors.add(:email, 'must be present unless phone is present')
      errors.add(:phone, 'must be present unless email is present')
    end
  end
end
