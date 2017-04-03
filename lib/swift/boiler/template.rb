module Swift
  module Boiler
    class Template 
        attr_accessor :template_path, :class_name, :date, :properties, :options

        def initialize
            @date = Time.now.strftime("%d/%m/%Y")
        end

    end 
  end
end
