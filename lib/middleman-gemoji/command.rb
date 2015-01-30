require "middleman-core/cli"
require "gemoji"

module Middleman
  module Cli
    class Gemoji < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :gemoji

      def initialize(*args)
        super
        Time.zone = ENV['TZ'] || "UTC"
      end

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "gemoji", "Copy emoji to destination directory"
      method_option "path",
        aliases: "-p",
        desc: "Destination path of directory",
        default: "images/emoji"
      def gemoji
        app    = ::Middleman::Application
        target = File.join(app.root, app.config.source, options[:path])
        source = File.expand_path('../../images/emoji/*', `gem which gemoji`)

        `mkdir -p #{target} && cp -Rp #{source} #{target}`
      end
    end
  end
end
