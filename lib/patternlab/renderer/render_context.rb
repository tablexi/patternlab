module Patternlab
  module Renderer
    class RenderContext < ActionView::Base
      def binding
        super
      end
    end
  end
end
