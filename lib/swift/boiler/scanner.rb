
require 'swift/boiler/token'
require 'swift/boiler/token_factory'
require 'swift/boiler/token_pattern_validator'

module Swift
  module Boiler
    class Scanner

      def create_valid_token_pattern_from_arguments(arguments)
        token_factory = Swift::Boiler::TokenFactory.new
        token_pattern_validator = Swift::Boiler::TokenPatternValidator.new
        tokens = token_factory.create_tokens_from_arguments(arguments)
        if token_pattern_validator.validate(tokens)
          return tokens
        else
          raise ArgumentError.new("The following sequence of arguments was not valid #{arguments}.")
        end

      end
    end
  end
end
