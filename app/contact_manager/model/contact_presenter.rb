# ContactPresenter is an enhanced Controller that also
# enables bidirectional data-binding of contact attributes
class ContactPresenter
  attr_accessor :contacts, :query, :current_contact
  
  def initialize
    self.current_contact = Contact.new
    self.contacts = Contact.all
    
    # Monitor Contact collection changes
    # the after_commit hook executes the block under a different object
    # binding, so we must use `this` to access self
    this = self
    Contact.after_commit(on: [:create, :update, :destroy]) do
      this.contacts = Contact.all
    end
  end
  
  def query=(query_value)
    @query = query_value
    if query_value.present?
      attribute_names = Contact.new.attributes.keys
      conditions = attribute_names.reduce('') do |conditions, attribute|
        if conditions.blank?
          conditions += "lower(#{attribute}) like ?"
        else
          conditions += " OR lower(#{attribute}) like ?"
        end
      end
      self.contacts = Contact.where(conditions, *(["%#{query_value.downcase}%"]*attribute_names.count))
    else
      self.contacts = Contact.all
    end
  end
  
  def save_current_contact
    current_contact.save.tap do |contact|
      self.current_contact = Contact.new if contact
    end
  end
end
