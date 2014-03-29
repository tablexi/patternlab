require 'nokogiri'
class HamlRenderer
  attr_reader :filename

  def self.render_all(directory_name)
    Dir["#{directory_name}/**/*.haml"].each do |file|
      HamlRenderer.new(file).render_and_save!
    end
  end

  def initialize(filename)
    @filename = filename
  end

  def render_and_save!
    new_name = @filename.sub /\.haml$/, '.mustache'
    File.open(new_name, 'w') do |f|
      f.write(render)
    end
  end

  def render
    template = File.read(@filename)
    haml_engine = Haml::Engine.new(template)
    haml_engine.render
  end





end
