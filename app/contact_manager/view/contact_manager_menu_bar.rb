class ContactManager
  module View
    class ContactManagerMenuBar
      include Glimmer::UI::CustomWidget
      
      options :about_action
  
      body {
        menu_bar {
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
