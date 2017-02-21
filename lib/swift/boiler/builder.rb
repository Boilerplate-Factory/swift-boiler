module Swift
  module Boiler
    class Builder

      def build_template(template_info) 
        Mustache.template_file = template_info.template_path
        template = Mustache.new
        template[:class_name] = template_info.class_name
        template[:dev_name] = template_info.dev_name
        template[:date] = template_info.date
        template[:options] = template_info.options
        template[:properties] = template_info.properties
        create_file(template.render.to_s, template_info.class_name)
      end

      def create_file(text, class_name)
        out_file = File.new(class_name + ".swift", "w")
        out_file.puts(text)
        out_file.close
      end

    end
  end
end
