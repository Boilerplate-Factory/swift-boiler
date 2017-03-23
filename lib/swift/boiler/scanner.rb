
require 'swift/boiler/token'
require 'swift/boiler/token_factory'
require 'swift/boiler/validator'

module Swift
  module Boiler
    class Scanner

      def scan(arguments)
      	token_factory = Swift::Boiler::TokenFactory.new
        validator = Swift::Boiler::Validator.new

        token_list = token_factory.create_token_list(arguments)
        if validator.validate_token_list(token_list)
        	return token_list
        else
        	raise ArgumentError.new("The following sequence of arguments was not valid #{arguments}.")
        end

      end
    end
  end
end
