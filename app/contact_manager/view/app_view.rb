require 'contact_manager/model/contact_presenter'

require 'contact_manager/view/contact_manager_menu_bar'
require 'contact_manager/view/contact_form'
require 'contact_manager/view/contact_table'

class ContactManager
  module View
    class AppView
      include Glimmer::UI::Application
      
      before_body do
        @contact_presenter = ContactPresenter.new
        
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
        
          @contact_form = contact_form(contact_presenter: @contact_presenter) {
            layout_data {
              horizontal_alignment :fill
              grab_excess_horizontal_space true
            }
          }
          
          contact_table(
            contact_presenter: @contact_presenter,
            reset_validations_action: @contact_form.method(:reset_validations),
          ) {
            layout_data {
              horizontal_alignment :fill
              grab_excess_horizontal_space true
              vertical_alignment :fill
              grab_excess_vertical_space true
            }
          }
        
          contact_manager_menu_bar(
            contact_presenter: @contact_presenter,
            about_action: method(:display_about_dialog),
            save_contact_action: @contact_form.method(:save_contact),
            reset_validations_action: @contact_form.method(:reset_validations),
          )
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
