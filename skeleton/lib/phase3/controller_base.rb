require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      contents = File.read(
        "views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
        )
      erb_contents = ERB.new(contents)
      result = erb_contents.result(binding)

      render_content(result, "text/html")
    end

  end
end
