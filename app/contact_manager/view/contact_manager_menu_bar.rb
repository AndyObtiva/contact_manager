class ContactManager
  module View
    class ContactManagerMenuBar
      include Glimmer::UI::CustomWidget

      ACCELERATOR_KEY = OS.mac? ? :command : :ctrl
      
      options :contact_presenter, :about_action, :save_contact_action, :reset_validations_action
  
      body {
        menu_bar {
          menu {
            text '&Contact'
            
            menu_item {
              text '&New'
              accelerator ACCELERATOR_KEY, :n
              
              on_widget_selected do
                contact_presenter.renew_current_contact
                reset_validations_action.call
              end
            }
            
            menu_item {
              text '&Save'
              accelerator ACCELERATOR_KEY, :s
              
              on_widget_selected do
                save_contact_action.call
              end
            }
            
            menu_item {
              text '&Delete...'
              accelerator ACCELERATOR_KEY, :d
              
              on_widget_selected do
                result = message_box(:yes, :no) {
                  text 'Delete'
                  message 'Are you sure you want to delete the selected contact?'
                }.open
                contact_presenter.destroy_current_contact if result == swt(:yes)
              end
            }
            
            menu_item {
              text 'Dele&te All...'
              
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
