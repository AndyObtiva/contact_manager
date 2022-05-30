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
            layout_data {
              height_hint 250
              horizontal_alignment :fill
              grab_excess_horizontal_space true
              vertical_alignment :fill
              grab_excess_vertical_space true
            }
            
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
              width 180
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
            
            selection <=> [contact_presenter, :current_contact]
            
            menu {
              menu_item {
                text '&Delete'
                
                on_widget_selected do
                  contact_presenter.destroy_current_contact
                end
              }
            }
          }
        }
      }
    end
  end
end
