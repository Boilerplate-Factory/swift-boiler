
require 'swift/boiler/token'

=begin
Symbols: 
ClassName, TemplateName, TemplatePath, Option, Property

Rules:
-> Option                                                        => swift-boil --help
-> Option -> TemplatePath -> ClassName -> [Property]             => swift-boil -t /Desktop/mytemplate.mustache MyView label:UILabel 
-> Option -> TemplatePath -> ClassName -> [Option] -> [Property]   => swift-boil -t /Desktop/mytemplate.mustache MyView -d label:UILabel 
-> TemplateName -> ClassName -> [Property]                       => swift-boil view MyView label:UILabel 
-> TemplateName -> ClassName -> [Option] -> [Property]             => swift-boil view MyView -d label:UILabel
=end

module Swift
  module Boiler
    class Scanner

      def scan(arguments)
        token_list = Array.new
        first_argument = arguments.shift
        
        if is_valid_option(first_argument) 
          token_list << Token.new(Token::OPTION, first_argument)
          
          if !arguments.empty?
             scan_tempalte_path(arguments).each { |element| token_list << element }
          end

        elsif is_valid_template_name(first_argument)
          token_list << Token.new(Token::TEMPLATE_NAME, first_argument)

           if arguments.empty?
            puts "Error: arguments are missing a class name"
            exit(0)
          else
            scan_class_name(arguments).each { |element| token_list << element }
          end

        else
          puts "Error: Swift-boiler does not recognize argument " + first_argument
          exit(0)
        end 

        token_list
      end

      def scan_tempalte_path(arguments)
        token_list = Array.new
        tempalte_path = arguments.shift

        if is_valid_template_path(tempalte_path) 
          token_list << Token.new(Token::TEMPLATE_PATH, tempalte_path) 
          scan_class_name(arguments).each { |element| token_list << element }

        else
          puts "Error: Swift-boiler expected a template path, but found " + tempalte_path + " instead"
          exit(0)
        end

        token_list
      end

      def scan_class_name(arguments)
        token_list = Array.new
        class_name = arguments.shift

        if is_valid_template_path(class_name) 
          token_list << Token.new(Token::CLASS_NAME, class_name)

          if !arguments.empty? && is_valid_option(arguments[0])
            token_list << Token.new(Token::OPTION, arguments.shift)
          end

          if !arguments.empty? 
            scan_properties(arguments).each { |element| token_list << element }
          end 

        else
          puts "Error: Swift-boiler expected a class name, but found " + class_name + " instead"
          exit(0)
        end

        token_list
      end

      def scan_properties(arguments)
        token_list = Array.new

        arguments.each { |argument| 
          if is_valid_property(argument)
            token_list << Token.new(Token::PROPERTY, argument)
          else
            puts "Error: Swift-boiler expected a property, but found " + argument + " instead"
            exit(0)
          end
        }

        token_list
      end
      
      def is_valid_option(argument)
        argument =~ /--[a-z]{1,}|-[a-z]/
      end

      def is_valid_property(argument)
        argument =~ /[a-z][a-zA-Z_\d]{1,}:[A-Z][a-zA-Z.\d]{1,}/
      end

      def is_valid_template_name(argument)
        ["controller", "c", "model", "m" "singleton", "s", "table_view_cell", "tableviewcell", "tvc", "view", "v", "viewmodel"].include?(argument)
      end

      def is_valid_class_name(argument)
        # TODO: think about requirements for class name
        true
      end

      def is_valid_template_path(argument)
        # TODO: look for a regular expression for file path..
        true
      end
   
    end
  end
end
