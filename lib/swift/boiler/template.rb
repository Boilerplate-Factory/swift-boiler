module Swift
  module Boiler
    class Template 
        attr_accessor :template_path, :class_name, :dev_name, :date, :properties, :options

        def initialize
            @dev_name = "<#T##Developer Name ##Name#>"
            @date = Time.now.strftime("%d/%m/%Y")
            @delegate = false
            @options = Array.new
            @properties = {}
            @properties[:ui_label] = Array.new
            @properties[:ui_view] = Array.new
            @properties[:unknow_type] = Array.new
        end

    end 
  end
end
