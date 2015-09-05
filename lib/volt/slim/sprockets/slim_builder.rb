module Volt
  module Slim
    module Sprockets
      class SlimBuilder
        def call(html)
          result = Volt::Slim::Compiler.new(template: html).build
          result
        end
      end
    end
  end
end

if defined?(Volt::ComponentTemplates)
  Volt::ComponentTemplates.register_template_handler(:slim, Volt::Slim::Sprockets::SlimBuilder.new)
end
