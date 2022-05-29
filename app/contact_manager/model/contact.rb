class Contact < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: {with: /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/, message: 'must be a valid email address'}
  validates :phone, format: {with: /\A[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.\/0-9]*\z/, message: 'must be a valid phone number'}
  validate :email_or_phone_is_present
  
  private
  
  def email_or_phone_is_present
    unless email || phone
      errors[:email] << 'must be present unless phone is present'
      errors[:phone] << 'must be present unless email is present'
    end
  end
end
