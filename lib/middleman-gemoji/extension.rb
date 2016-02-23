require_relative './converter'

module Middleman
  module Gemoji
    # Emoji Convert Extension of Middleman
    class Extension < ::Middleman::Extension
      option :size, nil, 'Size(width/height) of emoji im img tag'
      option :style, nil, 'Value of style attribute'
      option :emoji_dir, 'images/emoji', 'Path to Emoji directory from source'

      def initialize(app, options_hash = {}, &block)
        super
        converter = Middleman::Gemoji::Converter.new(app, options)
        app.before_render do |content|
          converter.convert(content)
        end
      end
    end
  end
end
