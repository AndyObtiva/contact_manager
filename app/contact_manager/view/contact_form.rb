class ContactManager
  module View
    class ContactForm
      include Glimmer::UI::CustomWidget
      
      options :contact_presenter
      
      body {
        composite {
          grid_layout {
            num_columns 2
            make_columns_equal_width true
            margin_width 0
            margin_height 0
          }
        
          form_column {
            form_field(:first_name)
            form_field(:last_name)
            form_field(:email)
            form_field(:phone)
          }
          
          form_column {
            form_field(:street)
            form_field(:city)
            form_field(:state_or_province)
            form_field(:zip_or_postal_code)
            form_field(:country)
          }
          
          composite { # having a composite ensures padding around button
            layout_data {
              horizontal_span 2
              horizontal_alignment :fill
              grab_excess_horizontal_space true
            }
            
            grid_layout {
              margin_height 0
            }
            
            button {
              layout_data {
                horizontal_alignment :fill
                grab_excess_horizontal_space true
              }
              
              text 'Save Contact'
              
              on_widget_selected do
                save_contact
              end
            }
          }
        }
      }
      
      def form_column(&content)
        composite { |the_composite|
          layout_data {
            horizontal_alignment :fill
            vertical_alignment :fill
            grab_excess_horizontal_space true
            grab_excess_vertical_space true
          }
          
          grid_layout {
            num_columns 2
            make_columns_equal_width false
          }
          
          content.call(the_composite)
        }
      end
      
      def form_field(field)
        @form_field_labels ||= {}
        @form_field_labels[field] = label {
          layout_data {
            width_hint 120
          }
          
          text field.to_s.gsub('_', ' ').titlecase
        }
        text {
          layout_data {
            width_hint 150
            horizontal_alignment :fill
            grab_excess_horizontal_space true
          }
          
          # use nested data-binding to monitor change of contact
          # in addition to contact field
          text <=> [contact_presenter, "current_contact.#{field}"]
          
          on_key_pressed do |event|
            save_contact if event.keyCode == swt(:cr)
          end
        }
      end
      
      def save_contact
        if contact_presenter.save_current_contact
          contact_presenter.current_contact.attributes.keys.each do |attribute_name|
            @form_field_labels[attribute_name.to_sym]&.foreground = :black
            @form_field_labels[attribute_name.to_sym]&.tool_tip_text = nil
          end
        else
          contact_presenter.current_contact.errors.errors.each do |error|
            @form_field_labels[error.attribute].foreground = :red
            @form_field_labels[error.attribute].tool_tip_text = error.full_message
          end
        end
      end
    end
  end
end
