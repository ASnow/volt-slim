module Volt
  module Slim
    module Filters
      # @api private
      class Controls < ::Slim::Controls
        def on_slim_output(escape, code, content)
          content.pop if content == [:multi, [:newline]]
          super
        end
        def on_slim_control(code, content)
          [:multi,
            [:code, code],
            compile(content)]
        end
      end
    end
  end
end
