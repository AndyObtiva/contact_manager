require 'contact_manager/model/contact'
require 'contact_manager/model/contact_repository'

# ContactPresenter is an enhanced Controller that also
# enables bidirectional data-binding of contact attributes
class ContactPresenter
  attr_accessor :contacts, :query, :current_contact
  
  def initialize
    self.current_contact = Contact.new
    self.contacts = ContactRepository.instance.all
    
    # Monitor Contact collection changes
    # the after_commit hook executes the block under a different object
    # binding, so we must use `this` to access self
    this = self
    Contact.after_commit(on: [:create, :update, :destroy]) do
      this.contacts = ContactRepository.instance.all
    end
  end
  
  def query=(query_value)
    @query = query_value
    self.contacts = ContactRepository.instance.search(query_value)
  end
  
  def save_current_contact
    current_contact.save.tap do |contact|
      self.current_contact = Contact.new if contact
    end
  end
  
  def destroy_current_contact
    if current_contact&.persisted?
      current_contact.destroy
      self.current_contact = Contact.new
    end
  end
end
