require 'mustache'
require 'swift/boiler/template'
require 'swift/boiler/token'

module Swift
  module Boiler
    class Parser

      def parse_tokens(tokens)
        template = Template.new
        first_argument = tokens.shift

        if first_argument.type == Token::OPTION && (first_argument.content == "-h" || first_argument.content == "--help")
          puts "TODO: write usage text"
          exit(0)

        elsif first_argument.type == Token::OPTION && (first_argument.content == "-t" || first_argument.content == "--template")
          template_path_token = tokens.shift
          template.template_path = parse_template_path(template_path_token)
        
        elsif first_argument.type == Token::TEMPLATE_NAME
          template.template_path = parse_template_path_from_name(first_argument)

        else
          puts "Error: swift-boil does not support: " + first_argument.content + " as the first argument"
          exit(0)
        end

        while !tokens.empty?
          current_token = tokens.shift
          if current_token.type == Token::OPTION

            if current_token.content == "-d" || current_token.content == "--delegate"
              template.options[:delegate] = true

            # elsif current_token.content == "-n" || current_token.content == "--name"
            #   template.dev_name = parse_dev_name(tokens)

            else
              puts "Error: swift-boil does not support: " + current_token.content + " as an option"
              exit(0)
            end
          
          elsif current_token.type == Token::CLASS_NAME
            template.class_name = current_token.content

          elsif current_token.type == Token::PROPERTY
            new_property = parse_properties(current_token)
            
            case new_property[:property_type].to_s
              when "UILabel"
                template.properties[:ui_label] << new_property
              when "UIView"
                template.properties[:ui_view] << new_property  
              else
                template.properties[:unknow_type] << new_property
            end
          else
            puts "Error: swift-boil does not support: " + current_token.content + " as an option"
            exit(0)
          end
    
        end

        template
      end

      def parse_template_path_from_name(token)
        shortcut_map = {
          tableviewcell: 'table_view_cell',
          m: 'model',
          v: 'view',
          c: 'controller',
          s: 'singleton',
          tvc: 'table_view_cell'
        }

        template_name = token.content.downcase
        path = File.dirname(__FILE__) + '/templates/' + template_name + ".mustache"

        if template_exists(path)
          return path   

        elsif shortcut_map.has_key?(template_name.to_sym)
          real_name = shortcut_map[template_name.to_sym]
          return File.dirname(__FILE__) + '/templates/' + real_name + ".mustache"
              
        else
            puts 'Could not find template for: ' + template_name
            exit(0)
        end
      end

      def parse_template_path(path_token)
        if template_exists(path_token.content)
          return path_token.content    
        else
            puts 'Could not find template for: ' + path_token.content
            exit(0)
        end

        path_token.content
      end

      def parse_dev_name(tokens)
        name_token = tokens.shift
        puts "developer name: " + name_token.content
        name_token.content
      end

    	def parse_properties(token)
    		argument_list = token.content.split(/:/)
    		build_new_property(argument_list[0], argument_list[1])
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

      def template_exists(path)
        isTemplateThere = File.exist?(path)
        isTemplateThere
      end

    end
  end
end
