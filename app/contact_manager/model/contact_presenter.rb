require 'contact_manager/model/contact'
require 'contact_manager/model/contact_repository'

# ContactPresenter is an enhanced Controller that also
# enables bidirectional data-binding of contact attributes
class ContactPresenter
  attr_accessor :contacts, :query, :current_contact
  
  def initialize
    renew_current_contact
    refresh_contacts
    
    # Monitor Contact collection changes
    # the after_commit hook executes the block under a different object
    # binding, so we must use `this` to access self
    this = self
    Contact.after_commit(on: [:create, :update, :destroy]) do
      this.refresh_contacts
    end
  end
  
  def query=(query_value)
    @query = query_value
    refresh_contacts
  end
  
  def current_contact=(new_contact)
    # first, reset current contact in case it was changed but not saved
    @current_contact&.reset!
    # next, update current contact
    @current_contact = new_contact
  end
  
  def refresh_contacts
    if query
      new_contacts = ContactRepository.instance.search(query)
    else
      new_contacts = ContactRepository.instance.all
    end
    
    if new_contacts != contacts
      self.contacts = new_contacts.to_a
      refresh_current_contact
    end
  end
  
  def refresh_current_contact
    current_contact_index = contacts.index(current_contact)
    self.current_contact = contacts[current_contact_index] if current_contact_index
  end
  
  def renew_current_contact
    self.current_contact = Contact.new
  end
  
  def save_current_contact
    current_contact.save.tap do |saved|
      renew_current_contact if saved
    end
  end
  
  def destroy_current_contact
    if current_contact&.persisted?
      current_contact.destroy
      renew_current_contact
    end
  end
  
  def destroy_all_contacts
    ContactRepository.instance.destroy_all_contacts
  end
end
