require 'db/db'

class Contact < ActiveRecord::Base
  STATES = [ 'AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
           'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME',
           'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM',
           'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX',
           'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']
  PROVINCES = ['NL', 'PE', 'NS', 'NB', 'QC', 'ON', 'MB', 'SK', 'AB', 'BC', 'YT', 'NT', 'NU']
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: {with: /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i, message: 'must be a valid email address'}, allow_blank: true
  validates :phone, format: {with: /\A[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.\/0-9]*\z/, message: 'must be a valid phone number'}, allow_blank: true
  validate :email_or_phone_is_present
  
  def address
    address_fields = [street, city, state_or_province, zip_or_postal_code, country]
    address_fields.map { |field| field.blank? ? nil : field }.compact.join(', ')
  end
  
  def country_options
    ['', 'Canada', 'USA']
  end
  
  def state_or_province_options
    (PROVINCES + [''] + STATES)
  end
  
  private
  
  def email_or_phone_is_present
    if email.blank? && phone.blank?
      errors.add(:email, 'must be present unless phone is present')
      errors.add(:phone, 'must be present unless email is present')
    end
  end
end
