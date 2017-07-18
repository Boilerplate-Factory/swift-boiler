require 'swift/boiler/builder'
require 'swift/boiler/scanner'
require 'swift/boiler/parser'
require 'swift/boiler/template'
require 'swift/boiler/token'

module Swift
  module Boiler
    class << self

      def boil(arguments)
        if is_help_request(arguments) 
          print_help_text()
        else 
          begin
            template = build_template_from_arguments(arguments)
            create_file_from_template(template)    
          rescue ArgumentError => argumentError
            print "swift-boiler: #{argumentError.message}. Please see 'swift-boil --help'."
          end
        end
      end
    
      private 

      def create_file_from_template(template)
        builder = Swift::Boiler::Builder.new
        builder.build_template(template)
      end

      def build_template_from_arguments(arguments)
        scanner = Swift::Boiler::Scanner.new
        parser = Swift::Boiler::Parser.new
        tokens = scanner.create_valid_token_pattern_from_arguments(arguments)
        template = parser.create_template_from_tokens(tokens)
        template
      end

      def is_help_request(arguments)
        return arguments[0] == '-h' || arguments[0] == '--help' || arguments == []
      end

      def print_help_text()        
        file = File.dirname(__FILE__) + '/boiler/templates/help.mustache'
        File.readlines(file).each do |line|
          puts line
        end
      end

    end
  end 
end
