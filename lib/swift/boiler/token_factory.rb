require 'swift/boiler/token'

module Swift
  module Boiler
    class TokenFactory

      def create_tokens_from_arguments(arguments)
        tokens = Array.new

        arguments.each do |argument|

          if is_valid_option(argument) 
            tokens << Token.new(Token::OPTION, argument)

          elsif is_valid_property(argument)
            tokens << Token.new(Token::PROPERTY, argument)

          elsif is_valid_template_name(argument)
            tokens << Token.new(Token::TEMPLATE_NAME, argument)

          elsif is_valid_template_path(argument)
            tokens << Token.new(Token::TEMPLATE_PATH, argument)

          elsif is_valid_class_name(argument)
            tokens << Token.new(Token::CLASS_NAME, argument)

          else
            raise ArgumentError.new("Argument was not recognized: #{argument}")
          end 
        end 

        tokens
      end
      
      def is_valid_option(argument)
        argument =~ /\A--[a-z]{3,}\z|\A-[a-z]\z/
      end

      def is_valid_property(argument)
        argument =~ /\A[a-zA-Z_][a-zA-Z_\d\-]*:[a-zA-Z][a-zA-Z_.\d\-]{2,}\z/
      end

      def is_valid_template_name(argument)
        ["controller", "c", "model", "m" "singleton", "s", "table_view_cell", "tableviewcell", "tvc", "view", "v", "viewmodel"].include?(argument)
      end

      def is_valid_class_name(argument)
        argument =~ /\A[a-zA-Z][a-zA-Z\d_]+\z/
      end

      def is_valid_template_path(argument)
        argument =~ /\A[a-zA-Z\-.\/\\~\s_:]*[\/\\][\w\-\s]+.mustache\z|\A[\w\-\s]+.mustache\z/
      end
    end
  end
end
