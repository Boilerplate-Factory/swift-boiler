require "swift/boiler/builder"

module Swift    
    module Boiler
    	AVAILABLE_ACTIONS = ["view"]

    	class << self
    		def boil(arguments) 
  				action = arguments.shift
  				parseAction(action, arguments)
  			end

  			def parseAction(action, arguments)
          builder = Swift::Boiler::Builder.new

  				case action.downcase
  				when "view"
  				  builder.boil_template("view.mustache", arguments)

  				when "tableviewcell"
  				  builder.boil_template("table_view_cell.mustache", arguments)
  				
  				else
  				  puts "Could not find template: " + action.downcase

  				end
  			end
    	end
	end
end
