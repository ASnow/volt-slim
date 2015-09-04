module Volt
  module Slim
    class SendlebarsGenerator < ::Temple::Generators::ERB
      def on_dynamic(code)
        "{{ #{code} }}"
      end

      def on_code(code)
        "{{ #{code} }}"
      end
    end
  end
end
