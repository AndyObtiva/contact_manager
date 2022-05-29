class ContactManager
  module View
    class ContactForm
      include Glimmer::UI::CustomWidget
      
      attr_accessor :contact
      
      before_body do
        @contact = Contact.new
      end
      
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
            form_field(:country)
            form_field(:zip_or_postal_code)
          }
          
          button {
            layout_data {
              horizontal_span 2
              horizontal_alignment :fill
              grab_excess_horizontal_space true
            }
            
            text 'Save Contact'
            
            on_widget_selected do
              contact.save! # TODO avoid bang and show errors when they occur
              self.contact = Contact.new
            end
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
        label {
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
          text <=> [self, "contact.#{field}"]
        }
      end
    end
  end
end
