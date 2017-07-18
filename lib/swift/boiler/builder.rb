module Swift
  module Boiler
    class Builder

      def build_template(template) 
        Mustache.template_file = template.template_path
        mustache_template = Mustache.new
        mustache_template[:class_name] = template.class_name
        mustache_template[:date] = template.date
        mustache_template[:options] = template.options
        mustache_template[:properties] = template.properties
        # puts template.inspect
        create_file(mustache_template.render.to_s, mustache_template[:class_name])
      end

      def create_file(text, class_name)
        puts text
        out_file = File.new(class_name + ".swift", "w")
        out_file.puts(text)
        out_file.close
      end

    end
  end
end
