module Volt
  module Slim
    module Filters
      # @api private
      class Controls < ::Slim::Controls
        def on_slim_control(code, content)
          [:multi,
            [:code, :indent],
            [:code, code],
            compile(content)]
        end
      end
    end
  end
end
