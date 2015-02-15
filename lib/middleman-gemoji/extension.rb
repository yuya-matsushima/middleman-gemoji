require 'gemoji'

module Middleman
  module Gemoji
    # Emoji Convert Extension of Middleman
    class Extension < ::Middleman::Extension
      option :size, nil, 'Size(width/height) of emoji im img tag'
      option :style, nil, 'Value of style attribute'
      option :emoji_dir, 'images/emoji', 'Path to Emoji directory from source'

      def initialize(app, options_hash = {}, &block)
        super
        @emoji_exist = Dir.exist?(
          File.join(app.config.source, options[:emoji_dir], 'unicode')
        )
        extension    = self

        app.before_render do |content|
          extension.emojify(content)
        end
      end

      def emojify(content)
        @base_path = base_path
        content.to_str.gsub(/:([\w+-]+):/) do |match|
          emoji = Emoji.find_by_alias($1)
          if emoji
            image = []
            image << %(alt="#{$1}")
            image << src(emoji.image_filename)
            image << size(options[:size]) if options[:size]
            image << style(options[:style]) if options[:style]

            %(<img class="gemoji" #{image.join(' ')} />)
          else
            match
          end if content.present?
        end
      end

      def src(path)
        %(src="#{File.join(@base_path, path)}")
      end

      def size(size)
        %(width="#{size}" height="#{size}")
      end

      def style(style)
        %(style="#{style}")
      end

      def base_path
        if @emoji_exist
          prefix = app.config[:http_prefix]
          if prefix && (/^http/ =~ prefix)
            File.join(app.config[:http_prefix], options[:emoji_dir])
          else
            File.join('/', app.config[:http_prefix], options[:emoji_dir])
          end
        else
          'https://assets-cdn.github.com/images/icons/emoji/'
        end
      end
    end
  end
end
