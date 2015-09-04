require "volt/slim/version"
require 'slim/erb_converter'

module Volt
  module Slim
    require "volt/slim/filters/attr_value_converter"
    require "volt/slim/filters/attribute_merger"
    require "volt/slim/filters/code_attributes"
    require "volt/slim/filters/pretty"
    require "volt/slim/filters/controls"
    require "volt/slim/sandlebars_generator"
    require "volt/slim/sandlebars_converter"
    require "volt/slim/compiler"
    require "volt/slim/sprockets/slim_template"
  end
end
