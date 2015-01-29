require "gemoji"

module Middleman
  module Gemoji
    class Extension < ::Middleman::Extension

      def initialize(app, options_hash = {}, &block)
        super

        extension = self
        app.after_render do |content|
          extension.emojify(content)
        end
      end

      def emojify(content)
        content.to_str.gsub(/:([\w+-]+):/) do |match|
          if emoji = Emoji.find_by_alias($1)
            %(<img alt="#$1" src="emoji/#{emoji.image_filename}" width="20" height="20" />)
          else
            match
          end if content.present?
        end
      end
    end
  end
end
