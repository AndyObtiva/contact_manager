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
            vertical_spacing 0
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
            form_field(:state_or_province, editor: :combo, editor_args: :read_only, property: :selection)
            form_field(:zip_or_postal_code)
            form_field(:country, editor: :combo, editor_args: :read_only, property: :selection)
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
      
      def form_field(field, editor: :text, editor_args: [], property: :text)
        @form_field_labels ||= {}
        @form_field_labels[field] = label {
          layout_data {
            width_hint 120
          }
          
          text field.to_s.gsub('_', ' ').titlecase
        }
        
        @form_field_texts ||= {}
        @form_field_texts[field] = send(editor, *editor_args) {
          layout_data {
            width_hint 150
            horizontal_alignment :fill
            grab_excess_horizontal_space true
          }
          
          # use nested data-binding to monitor change of contact
          # in addition to contact field
          send(property) <=> [contact_presenter, "current_contact.#{field}"]
          
          on_key_pressed do |event|
            save_contact if event.keyCode == swt(:cr)
          end
        }
      end
      
      def save_contact
        if contact_presenter.save_current_contact
          reset_validations
        else
          show_validations
        end
      end
      
      def reset_validations
        contact_presenter.current_contact.attributes.keys.each do |attribute_name|
          @form_field_labels[attribute_name.to_sym]&.foreground = :black
          @form_field_labels[attribute_name.to_sym]&.tool_tip_text = nil
        end
        focus_first_field
      end
      
      def show_validations
        contact_presenter.current_contact.errors.errors.each do |error|
          @form_field_labels[error.attribute].foreground = :red
          @form_field_labels[error.attribute].tool_tip_text = error.full_message
        end
      end
      
      def focus_first_field
        @form_field_texts[:first_name].set_focus
      end
    end
  end
end
