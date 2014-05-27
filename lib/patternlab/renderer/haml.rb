require 'patternlab/renderer/base'

module Patternlab
  module Renderer
    class Haml < Patternlab::Renderer::Base

      def self.extension
        "haml"
      end

      def engine
        ::Haml::Engine
      end

      def render
        template = File.read(@filename)
        haml_engine = ::Haml::Engine.new(template)
        haml_engine.render(RenderContext.new)
      end
    end
  end
end
