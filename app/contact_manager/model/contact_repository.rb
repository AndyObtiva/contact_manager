require 'singleton'
require 'contact_manager/model/contact'

class ContactRepository
  include Singleton
  
  def all
    Contact.all
  end
  
  def search(query_value)
    if query_value.present?
      attribute_names = Contact.new.attributes.keys
      conditions = attribute_names.reduce('') do |conditions, attribute|
        if conditions.blank?
          conditions += "lower(#{attribute}) like ?"
        else
          conditions += " OR lower(#{attribute}) like ?"
        end
      end
      Contact.where(conditions, *(["%#{query_value.downcase}%"]*attribute_names.count))
    else
      all
    end
  end
end
