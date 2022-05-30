class ContactManager
  module View
    class ContactManagerMenuBar
      include Glimmer::UI::CustomWidget
      
      options :contact_presenter, :about_action
  
      body {
        menu_bar {
          menu {
            text '&Contact'
            
            menu_item {
              text '&New'
              
              on_widget_selected do
                contact_presenter.renew_current_contact
              end
            }
            
            menu_item {
              text '&Delete All...'
              
              on_widget_selected do
                result = message_box(:yes, :no) {
                  text 'Delete All'
                  message 'Are you sure you want to delete all your contacts?'
                }.open
                contact_presenter.destroy_all_contacts if result == swt(:yes)
              end
            }
          }
          
          menu {
            text '&Help'
            
            menu_item {
              text '&About...'
              
              on_widget_selected do
                about_action.call
              end
            }
          }
        }
      }
  
    end
  end
end
