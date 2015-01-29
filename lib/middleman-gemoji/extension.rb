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
            image = []

            image << %(alt="#{$1}")
            image << %(src="#{File.join("/", app.config[:http_prefix], options[:emoji_dir], emoji.image_filename)}")
            image << %(width="#{options[:size]}" height="#{options[:size]}") if options[:size]
            image << %(style="#{options[:style]}") if options[:style]

            "<img #{image.join(" ")} />"
          else
            match
          end if content.present?
        end
      end

    end
  end
end
