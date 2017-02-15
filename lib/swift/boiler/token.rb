module Swift
  module Boiler
    class Token 
        attr_accessor :type, :content
        
        TYPE = [
            OPTION = :option_type,
            PROPERTY = :property_type,
            TEMPLATE_NAME = :template_name_type,
            TEMPLATE_PATH = :template_path_type,
            CLASS_NAME = :class_name_type,
        ]

        def initialize (type, content)
            @type = type
            @content = content 
        end

    end 
  end
end
