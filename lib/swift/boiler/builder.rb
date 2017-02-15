require 'swift/boiler/parser'

module Swift
  module Boiler
    class Builder

        shortcut_map = {
            tableviewcell: 'table_view_cell',
            m: 'model',
            v: 'view',
            c: 'controller',
            s: 'singleton',
            tvc: 'table_view_cell'
        }

    	def boil_template(template_name, arguments) 
    		Mustache.template_file = File.dirname(__FILE__) + '/templates/' + template_name
    		parser = Parser.new
    		class_name = arguments.shift

    		template = Mustache.new
    		template[:class_name] = class_name
    		template[:dev_name] = "Pedro Peres"
    		template[:date] = Time.now.strftime("%d/%m/%Y")
    		template[:properties] = parser.parse_properties(arguments)
    		template[:options] = parser.parse_options(arguments)
    		create_file(template.render.to_s, class_name)
    	end

    	def create_file(text, class_name)
    		out_file = File.new(class_name + ".swift", "w")
			out_file.puts(text)
			out_file.close
    	end

			def template_exists(template_name)
				path = File.dirname(__FILE__) + '/templates/' + template_name
				File.exist?(path)
			end
		end
  end
end
