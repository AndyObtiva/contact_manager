class ContactManager
  module View
    class ContactTable
      include Glimmer::UI::CustomWidget
      
      attr_accessor :contacts, :query
    
      before_body do
        self.contacts = Contact.all
        
        # Monitor Contact collection changes
        # the after_commit hook executes the block under a different object
        # binding, so we must use `this` to access self
        this = self
        Contact.after_commit(on: [:create, :update, :destroy]) do
          this.contacts = Contact.all
        end
      end
            
      body {
        composite {
          grid_layout
          
          text(:search) {
            layout_data {
              horizontal_alignment :fill
              grab_excess_horizontal_space true
            }
            
            text <=> [self, :query,
              after_write: ->(query_value) {
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
              }
            ]
          }
          
          table {
            table_column {
              text 'First Name'
              width 120
            }
            table_column {
              text 'Last Name'
              width 120
            }
            table_column {
              text 'Email'
              width 150
            }
            table_column {
              text 'Phone'
              width 120
            }
            table_column {
              text 'Address'
              width 320
            }
            
            # Ensure converting to Array on read because contacts is an ActiveRecord collection,
            # but an Array object is required by Glimmer DSL for SWT table data-binding logic
            items <= [self, :contacts, on_read: :to_a, column_properties: [:first_name, :last_name, :email, :phone, :address]]
            
            # TODO bind selection to loading and editing via form
          }
        }
      }
    end
  end
end
