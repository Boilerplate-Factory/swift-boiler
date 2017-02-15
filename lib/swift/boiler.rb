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
        parser = Swift::Boiler::Builder.new
        builder = Swift::Boiler::Builder.new
        token_list = scanner.scan(arguments)

        # action = arguments.shift
        # parse_action(action, arguments)
      end

      def parse_action(action, arguments)
        builder = Swift::Boiler::Builder.new
        key = action.downcase
        template = key + '.mustache'

        shortcut_map = {
            tableviewcell: 'table_view_cell',
            m: 'model',
            v: 'view',
            c: 'controller',
            s: 'singleton',
            tvc: 'table_view_cell'
        }

        # default - look for templates that match this action
        if builder.template_exists(template)
          builder.boil_template(template, arguments)
        elsif shortcut_map.has_key?(key.to_sym)
            # shortcuts - look for specific actions
            builder.boil_template(shortcut_map[key.to_sym] + '.mustache', arguments)
        else
            puts 'Could not find template for: ' + key
        end

      end
    end
  end
end
