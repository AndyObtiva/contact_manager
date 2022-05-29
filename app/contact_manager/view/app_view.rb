require 'contact_manager/view/contact_manager_menu_bar'
require 'contact_manager/view/contact_form'
require 'contact_manager/view/contact_table'

class ContactManager
  module View
    class AppView
      include Glimmer::UI::CustomShell
      
      before_body do
        Display.app_name = 'Contact Manager'
        Display.app_version = VERSION
        @display = display {
          on_about do
            display_about_dialog
          end
          
          on_preferences do
            display_about_dialog
          end
        }
      end
      
      body {
        shell {
          grid_layout
          
          image File.join(APP_ROOT, 'icons', 'windows', "Contact Manager.ico") if OS.windows?
          image File.join(APP_ROOT, 'icons', 'linux', "Contact Manager.png") unless OS.windows?
          text "Contact Manager"
        
          contact_manager_menu_bar(about_action: method(:display_about_dialog))
        
          contact_form {
            layout_data {
              horizontal_alignment :fill
              grab_excess_horizontal_space true
            }
          }
          
          contact_table {
            layout_data {
              horizontal_alignment :fill
              grab_excess_horizontal_space true
              vertical_alignment :fill
              grab_excess_vertical_space true
            }
          }
        }
      }
  
      def display_about_dialog
        message_box(body_root) {
          text 'About'
          message "Contact Manager #{VERSION}\n\n#{LICENSE}"
        }.open
      end
    end
  end
end
