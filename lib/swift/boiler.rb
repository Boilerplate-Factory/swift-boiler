require 'swift/boiler/builder'
require 'swift/boiler/scanner'
require 'swift/boiler/parser'
require 'swift/boiler/template'
require 'swift/boiler/token'

module Swift
  module Boiler
    class << self

      def boil(arguments)
        begin
          tempalte = build_template_from_arguments(arguments)
          create_file_from_template(template)    
        rescue ArgumentError => argumentError
          print "swift-boiler: #{argumentError.message}. Please see 'swift-boil --help'."
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

    end
  end 
end
