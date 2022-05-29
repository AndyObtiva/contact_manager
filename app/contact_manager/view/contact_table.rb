class ContactManager
  module View
    class ContactTable
      include Glimmer::UI::CustomWidget
      
      options :contact_presenter
      
      body {
        composite {
          grid_layout
          
          text(:search) {
            layout_data {
              horizontal_alignment :fill
              grab_excess_horizontal_space true
            }
            
            text <=> [contact_presenter, :query]
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
            items <= [contact_presenter, :contacts, on_read: :to_a, column_properties: [:first_name, :last_name, :email, :phone, :address]]
            
            # TODO bind selection to loading and editing via form
            # do so by refactoring to use a ContactPresenter shared with both ContactForm and ContactTable
            
            # TODO implement right click menu for delete contact
          }
        }
      }
    end
  end
end
