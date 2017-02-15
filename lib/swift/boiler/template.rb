module Swift
  module Boiler
    class Template 
        attr_accessor :template_path, :class_name, :dev_name, :date, :properties, :options

        def initialize (type, content)
            @dev_name = "<#T##Developer Name ##Name#>"
            @date = Time.now.strftime("%d/%m/%Y")
        end

    end 
  end
end
