require "gemoji"

module Middleman
  module Gemoji
    class Extension < ::Middleman::Extension
      option :size, nil, "Size(width/height) of emoji im img tag"
      option :style, nil, "Value of style attribute"
      option :emoji_dir, "images/emoji", "Path to Emoji directory from source"

      def initialize(app, options_hash = {}, &block)
        super

        extension = self
        app.after_render do |content|
          extension.emojify(content)
        end
      end

      def emojify(content)
        content.to_str.gsub(/:([\w+-]+):/) do |match|
          params = {}
          if emoji = Emoji.find_by_alias($1)
            params[:alt]   = $1
            params[:size]  = options[:size] if options[:size]
            params[:style] = options[:style] if options[:style]

            image_tag(File.join(options[:emoji_dir], emoji.image_filename), params)
          else
            match
          end if content.present?
        end
      end

    end
  end
end
