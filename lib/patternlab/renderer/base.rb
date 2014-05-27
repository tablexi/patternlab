require 'patternlab/renderer/render_context'

module Patternlab
  module Renderer
    class Base
      attr_reader :filename

      def self.render_all(directory_name)
        Dir["#{directory_name}/**/*.#{extension}"].each do |file|
          new(file).render_and_save!
        end
      end

      def self.extension
        raise "Subclass must implement"
      end

      def initialize(filename)
        @filename = filename
      end

      def extension
        self.class.extension
      end

      def render_and_save!
        new_name = @filename.sub /\.#{extension}$/, '.mustache'
        File.open(new_name, 'w') do |f|
          f.write(render)
        end
      end

      def render
        raise "Subclass must implement"
      end
    end
  end
end
