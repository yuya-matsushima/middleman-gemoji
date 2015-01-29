module Middleman
  module Gemoji
    class Extension < ::Middleman::Extension

      def initialize(app, options_hash = {}, &block)
        super

        app.after_render do |content|
          content
        end
      end

    end
  end
end
