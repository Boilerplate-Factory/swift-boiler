
require 'swift/boiler/token'

=begin
Rules:
option_only_pattern   -> <option>                                                 
template_path_pattern -> <option> -> <template_path> -> <class_name> -> <properties>       
template_path_pattern -> <option> -> <template_path> -> <class_name> -> <option> -> <properties>
template_name_pattern -> <template_name> -> <class_name> -> <properties>    
template_name_pattern -> <template_name> -> <class_name> -> <option> -> <properties> 
=end

module Swift
  module Boiler
    class Validator

      def validate_token_list(token_list)
        if token_list.count > 0 
          is_first_element_option_type = (token_list[0].type == Token::OPTION)
          has_template_name = token_list_contains_one_instace_of_type(token_list, Token::TEMPLATE_NAME)
          has_template_path = token_list_contains_one_instace_of_type(token_list, Token::TEMPLATE_PATH)
          has_class_name = token_list_contains_one_instace_of_type(token_list, Token::CLASS_NAME)
          return is_token_list_valid(token_list.count, is_first_element_option_type, has_template_name, has_template_path, has_class_name)        
        else
          return false
        end
      end

      def is_token_list_valid(list_count, is_first_element_option_type, has_template_name, has_template_path, has_class_name)
        has_option_only_pattern(list_count, is_first_element_option_type, has_template_name, has_template_path, has_class_name) ||
        has_template_path_pattern(is_first_element_option_type, has_template_name, has_template_path, has_class_name) ||
        has_template_name_pattern(is_first_element_option_type, has_template_name, has_template_path, has_class_name)
      end

      def has_template_path_pattern(is_first_element_option_type, has_template_name, has_template_path, has_class_name)
        is_first_element_option_type && !has_template_name && has_template_path && has_class_name
      end

      def has_template_name_pattern(is_first_element_option_type, has_template_name, has_template_path, has_class_name)
        has_template_name && !has_template_path && has_class_name
      end

      def has_option_only_pattern(list_count, is_first_element_option_type, has_template_name, has_template_path, has_class_name)
        is_first_element_option_type && (list_count == 1) && !has_template_name && !has_template_path && !has_class_name
      end

      def token_list_contains_one_instace_of_type(token_list, type)
        instance_counter = 0
        token_list.each do |token|
          if token.type == type
            instance_counter += 1
          end
        end
        instance_counter == 1
      end
    end
  end
end
