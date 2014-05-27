require 'patternlab/renderer/base'

module Patternlab
  module Renderer
    class Erb < Patternlab::Renderer::Base
      def self.extension
        "erb"
      end

      def engine
        ERB
      end

      def render
        template = File.read(@filename)
        erb = engine.new(template)
        erb.result(RenderContext.new.binding)
      end
    end
  end
end
