module Volt
  module Slim
    module Filters
      # @api private
      class Pretty < ::Temple::HTML::Pretty

        def on_dynamic(code)
          return [:dynamic, code] unless @pretty
          indent_next, @indent_next = @indent_next, false
          [:multi, [:static,  ((options[:indent] || '') * @indent)], [:dynamic, code]]
        end

        def on_code(code)
          if code =~ ::Slim::EndInserter::END_RE
            [:multi, [:static,  ("\n"+(options[:indent] || '') * @indent)], [:code, code]]
          elsif code == :indent
            [:static,  ("\n"+(options[:indent] || '') * @indent)]
          else
            [:code, code]
          end
        end

        def preamble
          [:multi]
        end

        SANDLEBARS_PREFIXES_RE = /\A(tpl|use)-/
        def on_html_tag(name, attrs, content = nil)
          if name =~ SANDLEBARS_PREFIXES_RE
            closed = empty_exp?(content)
            is_template, sb_name = sendlebars name
            indent = tag_indent(name)
            result = [:multi, [:static, "#{indent}<:#{sb_name}"], compile(attrs)]
            result << [:static, (closed ? ' /' : '') + '>']
            unless closed
              @indent += 1
              result << compile(content)
              @indent -= 1
              result << [:static, "#{indent}</:#{sb_name}>"] unless is_template
            end
            result
          else
            super
          end
        end

        TEMPLATE_TAG = %r{tpl-(.+)}i
        PARTIAL_TAG = %r{use-(.+)}i
        PARTIAL_TAG_REPLACE = '<:\1\2>'
        def sendlebars name
          case name
          when TEMPLATE_TAG then [true, $1.capitalize]
          when PARTIAL_TAG then [false, $1]
          end
        end
        # def tag_indent(name)
        #   if name =~ /\A(tpl|use)-/
        #     indent
        #   else
        #     super
        #   end
        # end
      end
    end
  end
end
