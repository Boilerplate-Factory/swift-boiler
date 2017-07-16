require 'mustache'
require 'swift/boiler/template'
require 'swift/boiler/token'

module Swift
  module Boiler
    class Parser

      TYPE = :type
      NAME = :name
      PROPERTY_NAME_INDEX = 0
      PROPERTY_TYPE_INDEX = 1
      CAPITALIZED_NAME = :capitalized_name
      LABEL_TYPE = :ui_label
      VIEW_TYPE = :ui_view
      UNKNOWN_TYPE = :unknow_type
      SHORTCUTS = { tableviewcell: 'table_view_cell', m: 'model', v: 'view', c: 'controller', s: 'singleton', tvc: 'table_view_cell' }

      def create_template_from_tokens(tokens)
        template = Template.new
        template.template_path = get_template_path(tokens)
        template.class_name = get_class_name(tokens)
        template.options = get_options(tokens)
        template.properties = get_properties(tokens)
        template
      end

      def get_template_path(tokens)
        tokens.each do |token|
          if is_path_generation_possible_from_token(token)
            return get_template_path_from_token(token)
          end
        end
      end

      def is_path_generation_possible_from_token(token)
        is_template_path_token(token) || is_template_name_token(token)
      end

      def get_template_path_from_token(token)
        if is_template_path_token(token)
          return get_template_path_from_path_token(token)
        elsif is_template_name_token(token)
          return get_template_path_from_name_token(token)
        end
      end

      def get_class_name(tokens)
        tokens.each do |token|
          if is_class_name_token(token)
            return token.content
          end
        end
      end

      def get_options(tokens)
        options = {}
        tokens.each do |token|
          options[:protocol] = is_protocol_token(token)
        end
        options
      end

      def get_properties(tokens)
        properties = {}
        properties[LABEL_TYPE] = Array.new
        properties[VIEW_TYPE] = Array.new
        properties[UNKNOWN_TYPE] = Array.new
        tokens.each do |token|
          if token.type == Token::PROPERTY
            new_property = get_property_from_token(token) 
            case new_property[TYPE].to_s
              when "UILabel"
                properties[LABEL_TYPE] << new_property
              when "UIView"
                properties[VIEW_TYPE] << new_property  
              else
                properties[UNKNOWN_TYPE] << new_property
            end
          end
        end
        properties
      end

      def get_template_path_from_path_token(token)
        token.content
      end

      def get_template_path_from_name_token(token)
        template_name = get_template_name_from_token(token)
        File.dirname(__FILE__) + '/templates/' + template_name + ".mustache" 
      end

      def get_template_name_from_token(template_name_token)
        if is_abreviation(template_name_token)
          get_name_from_abreviation(template_name_token.content.downcase)
        else
          get_name_from_name_token(template_name_token)
        end
      end

      def get_property_from_token(token)
        name = get_property_name_from_token(token)
        type = get_property_type_from_token(token)
        capitalized_name = capitalize_name(name)
        create_property_dictionary(name, capitalized_name, type)
      end

      def create_property_dictionary(name, capitalized_name, type)
        property = {}
        property[NAME] = name
        property[TYPE] = type
        property[CAPITALIZED_NAME] = capitalized_name
        property
      end

      def get_property_name_from_token(token)
        argument_list = token.content.split(/:/)
        name = argument_list[PROPERTY_NAME_INDEX]
        downcase_name(name)
      end

      def get_property_type_from_token(token)
        argument_list = token.content.split(/:/)
        argument_list[PROPERTY_TYPE_INDEX]
      end

      def capitalize_name(name)
        name.split.map(&:capitalize).join(' ')
      end

      def downcase_name(name)
        place_holder = name.dup
        first_letter = place_holder.slice!(0).downcase
        first_letter + place_holder
      end

      def get_name_from_abreviation(abreviation)
        print SHORTCUTS[abreviation.to_sym]
        SHORTCUTS[abreviation.to_sym] 
      end

      def get_name_from_name_token(template_name_token)
        template_name_token.content.downcase
      end

      def is_abreviation(template_name_token)
        template_name = template_name_token.content.downcase
        template_name_token.type == Token::TEMPLATE_NAME && SHORTCUTS.has_key?(template_name.to_sym)
      end

      def is_protocol_token(token) 
        token.type == Token::OPTION && (token.content == "-p" || token.content == "--protocol")
      end

      private

      def is_template_path_token(token)
        token.type == Token::TEMPLATE_PATH
      end

      def is_template_name_token(token)
        token.type == Token::TEMPLATE_NAME
      end

      def is_class_name_token(token)
        token.type == Token::CLASS_NAME
      end

    end
  end
end
