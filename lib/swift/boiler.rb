require 'swift/boiler/builder'
require 'swift/boiler/scanner'
require 'swift/boiler/parser'
require 'swift/boiler/template'
require 'swift/boiler/token'

module Swift
  module Boiler
      class << self

      def boil(arguments)
        scanner = Swift::Boiler::Scanner.new
        parser = Swift::Boiler::Parser.new
        builder = Swift::Boiler::Builder.new
        token_list = scanner.scan(arguments)
        template_info = parser.parse_tokens(token_list)
        builder.build_template(template_info)
      end
      
    end
  end
end
