require 'mustache'

module Swift
  module Boiler
    class Parser

    	def parse_properties(arguments)
        possible_properties = arguments.select { |item| item.include?(":") }
    		properties = {}
    		ui_view_list = []
    		ui_label_list = []
    		unknown_type_list = [] 

    		possible_properties.each { |possible_property| 
    			argument_list = possible_property.split(/:/)
    			new_property = build_new_property(argument_list[0], argument_list[1])
    			
    			case new_property[:property_type].to_s
  				when "UILabel"
  					ui_label_list << new_property
  				when "UIView"
  					ui_view_list << new_property	
  				else
  					unknown_type_list << new_property
  				end
    		}
    		
    		ui_label_list.any? { ui_label_list.first[:first] = true }    
    		ui_view_list.any? { ui_view_list.first[:first] = true }    		
    		unknown_type_list.any? { unknown_type_list.first[:first] = true }    		
    		properties[:ui_label] = ui_label_list
    		properties[:ui_view] = ui_view_list
    		properties[:unknow_type] = unknown_type_list
    		properties
    	end

      def parse_options(arguments)
        possible_options = arguments.select { |item| item.include?("-") }
        options = {}
        possible_options.each { |possible_option| 
          case possible_option
          when "-d", "--delegate", "--delegate"
            options[:delegate] = true

          when "-h", "-help", "--help"
            puts "help text!!"
              exit(0)
          
          else
              puts "bad option: " + argument.to_s
              exit(0)
          end
        }

        options
      end

    	def build_new_property(name, type)
    		new_property = {}
    		new_property[:property_name] = name
    		new_property[:property_type] = type
    		new_property[:cap_property_name] = get_cap_name(name)
    		new_property
    	end

    	def get_cap_name(name)
    		place_holder = name.dup
    		first_letter = place_holder.slice!(0).capitalize
    		first_letter + place_holder
    	end
    end
  end
end
