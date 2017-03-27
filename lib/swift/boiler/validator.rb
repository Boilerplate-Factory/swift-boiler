
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
        token_list.count > 0 && is_token_list_valid(token_list)
      end

      def is_token_list_valid(token_list)
        is_help_pattern(token_list) || is_template_path_pattern(token_list) || is_template_name_pattern(token_list)
      end

      def is_template_path_pattern(token_list)
        has_one_template_name = token_list_contains_one_instace_of_type(token_list, Token::TEMPLATE_NAME)
        has_one_template_path = token_list_contains_one_instace_of_type(token_list, Token::TEMPLATE_PATH)
        has_one_class_name = token_list_contains_one_instace_of_type(token_list, Token::CLASS_NAME)
        !has_one_template_name && has_one_template_path && has_one_class_name && is_first_token_template_option(token_list)
      end

      def is_template_name_pattern(token_list)
        has_one_template_name = token_list_contains_one_instace_of_type(token_list, Token::TEMPLATE_NAME)
        has_one_template_path = token_list_contains_one_instace_of_type(token_list, Token::TEMPLATE_PATH)
        has_one_class_name = token_list_contains_one_instace_of_type(token_list, Token::CLASS_NAME)
        !has_one_template_path && has_one_class_name && has_one_template_name && is_first_token_template_name_type(token_list)
      end

      def is_help_pattern(token_list)
          token_list.count == 1 && is_first_token_help_option(token_list)
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

      def is_first_token_template_name_type(token_list)
        if token_list.count > 0 
          token_list[0].type == Token::TEMPLATE_NAME
        else
          false
        end 
      end

      def is_first_token_help_option(token_list) 
        if token_list.count > 0 
          first_token = token_list[0]
          first_token.type == Token::OPTION && (first_token.content == '-h' || first_token.content == '--help')
        else
          false
        end 
      end

      def is_first_token_template_option(token_list) 
        if token_list.count > 0 
          first_token = token_list[0]
          first_token.type == Token::OPTION && (first_token.content == '-t' || first_token.content == '--template')
        else
          false
        end
      end
      
    end
  end
end
