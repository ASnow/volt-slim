require 'ripper'
require 'sorcerer'

module Volt
  module Slim
    module Filters
      # @api private
      class AttrValueConverter < ::Slim::Filter
        ANY_RE = /\b(if|unless|else|elsif|when|rescue|ensure)\b|\b?\b|\bdo\s*(\|[^\|]*\|)?\s*|$\b(else|elsif|when|rescue|ensure)\b|\bend\b/

        def on_slim_attrvalue(escape, code)
          if code =~ ANY_RE
            a = convert code
            a
          else
            [:dynamic, code]
          end
        end

        TMP_SYMBOL_RE = /(?=:__volt_slim\d+)/
        TMP2_SYMBOL_RE = /(:__volt_slim(\d+))?(.+)/
        def convert code
          builder = CustomSexp.new(code)
          string = Sorcerer.source builder.parse
          code = string.split(TMP_SYMBOL_RE).each_with_object([]) do |chunk, obj|
            chunk =~ TMP2_SYMBOL_RE
            obj << [:dynamic, Sorcerer.source(builder.storage[$2.to_i])]if $2
            obj << [:code, $3]
          end
          code.unshift :multi
          code
        end
        class CustomSexp < ::Ripper::SexpBuilder
          attr_reader :storage
          def on_if(*args)
            args[1] = new_symbol args[1]
            super
          end

          def on_ifop(*args)
            args[1] = [:stmts_add, [:stmts_new], new_symbol(args[1])]
            args[2] = [:else, [:stmts_add, [:stmts_new], new_symbol(args[2])]]
            args.unshift :if
            args
          end

          def on_else(*args)
            args[0] = new_symbol args[0]
            super
          end
          def on_elsif(*args)
            args[1] = new_symbol args[1]
            super
          end

          def initialize(*args)
            @storage = []
            super
          end

          def new_symbol store
            index = @storage.size
            position = find_position store
            @storage.push store

            [:symbol_literal, [:symbol, [:@ident, "__volt_slim#{index}", position]]]
          end

          def find_position arr
            return nil unless arr.is_a? Array
            return arr.last if SCANNER_EVENTS.include?(arr.first)
            arr[1..-1].each do |item| 
              result = find_position item
              return result if result
            end
            nil
          end
        end
      end
    end
  end
end
