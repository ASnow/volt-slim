module Volt
  module Slim
    class SandlebarsConverter < ::Slim::ERBConverter
      replace :'Slim::CodeAttributes', Volt::Slim::Filters::CodeAttributes
      # before :'Volt::Slim::Filters::CodeAttributes', Volt::Slim::Filters::AttrValueConverter
      replace :AttributeMerger, Volt::Slim::Filters::AttributeMerger
      replace :Pretty, Volt::Slim::Filters::Pretty
      replace :'Slim::Controls', Volt::Slim::Filters::Controls
      replace :'Temple::Generators::ERB', Volt::Slim::SendlebarsGenerator

      # remove :AttributeMerger
      remove :AttributeRemover
      remove :'Temple::Filters::CodeMerger'
    end
  end
end
