module Volt
  module Slim
    class Compiler
      def self.build template
        SandlebarsConverter.new({pretty: false, use_html_safe: false, disable_escape: true}).call(template)
      end
    end
  end
end
