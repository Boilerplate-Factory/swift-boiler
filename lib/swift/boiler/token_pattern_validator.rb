require 'swift/boiler/token'

module Swift
  module Boiler
    class TokenPatternValidator

      def validate(tokens)
        tokens.count > 0 && is_token_pattern_valid(tokens)
      end

      def is_token_pattern_valid(tokens)
        is_help_pattern(tokens) || is_template_path_pattern(tokens) || is_template_name_pattern(tokens)
      end

      def is_template_path_pattern(tokens)
        has_one_template_name = contains_unique_instace_of_type(tokens, Token::TEMPLATE_NAME)
        has_one_template_path = contains_unique_instace_of_type(tokens, Token::TEMPLATE_PATH)
        has_one_class_name = contains_unique_instace_of_type(tokens, Token::CLASS_NAME)
        !has_one_template_name && has_one_template_path && has_one_class_name && is_first_token_template_option(tokens)
      end

      def is_template_name_pattern(tokens)
        has_one_template_name = contains_unique_instace_of_type(tokens, Token::TEMPLATE_NAME)
        has_one_template_path = contains_unique_instace_of_type(tokens, Token::TEMPLATE_PATH)
        has_one_class_name = contains_unique_instace_of_type(tokens, Token::CLASS_NAME)
        !has_one_template_path && has_one_class_name && has_one_template_name && is_first_token_template_name_type(tokens)
      end

      def is_help_pattern(tokens)
          tokens.count == 1 && is_first_token_help_option(tokens)
      end

      def contains_unique_instace_of_type(tokens, type)
        instance_counter = 0
        tokens.each do |token|
          if token.type == type
            instance_counter += 1
          end
        end
        instance_counter == 1
      end

      def is_first_token_template_name_type(tokens)
        tokens.count > 0 && is_template_name_token(tokens[0])
      end

      def is_first_token_help_option(tokens) 
        tokens.count > 0 && is_help_token(tokens[0])
      end

      def is_first_token_help_option(tokens) 
        tokens.count > 0 && is_help_token(tokens[0])
      end

      def is_first_token_template_option(tokens) 
        tokens.count > 0 && is_template_token(tokens[0])
      end

      def is_template_name_token(token) 
        token.type == Token::TEMPLATE_NAME
      end

      def is_help_token(token)
        token.type == Token::OPTION && (token.content == '-h' || token.content == '--help')
      end

      def is_template_token(token)
        token.type == Token::OPTION && (token.content == '-t' || token.content == '--template')
      end
      
    end
  end
end
