require 'gemoji'

module Middleman
  module Gemoji
    class Converter
      def initialize(config, options)
        @config = config
        @options = options
        @emoji_exist = Dir.exist?(
          File.join(config.source, options[:emoji_dir], 'unicode')
        )
      end

      def convert(content)
        content.to_str.gsub(/:([\w+-]+):/) do |match|
          emoji = Emoji.find_by_alias($1)
          if emoji
            image = []
            image << %(alt="#{$1}")
            image << src(emoji.image_filename)
            image << size(@options[:size]) if @options[:size]
            image << style(@options[:style]) if @options[:style]

            %(<img class="gemoji" #{image.join(' ')} />)
          else
            match
          end if content.present?
        end
      end

      private
      def src(filename)
        %(src="#{File.join(base_path, filename)}")
      end

      def size(size)
        %(width="#{size}" height="#{size}")
      end

      def style(style)
        style ? %(style="#{style}") : ''
      end

      def base_path
        if @emoji_exist
          prefix = @config[:http_prefix]
          if prefix && (/^http/ =~ prefix)
            File.join(@config[:http_prefix], @options[:emoji_dir])
          else
            File.join('/', @config[:http_prefix], @options[:emoji_dir])
          end
        else
          'https://assets-cdn.github.com/images/icons/emoji/'
        end
      end
    end
  end
end
