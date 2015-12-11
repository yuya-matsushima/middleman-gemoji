require 'middleman-core/cli'
require 'gemoji'

module Middleman
  module Cli
    # Command Class
    class Gemoji < Thor::Group
      include Thor::Actions

      check_unknown_options!

      #namespace :gemoji

      def initialize(*args)
        super
      end

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      class_option 'path',
        type: :string,
        default: 'images/emoji',
        aliases: '-p',
        desc: 'Destination path of directory'

      def install
        app    = ::Middleman::Application
        target = File.join(app.root, app.config.source, options[:path])
        source = File.expand_path('../../images/emoji/*', `gem which gemoji`)

        `mkdir -p #{target} && cp -Rp #{source} #{target}`
      end

      # Add to CLI
      Base.register(self, 'gemoji', 'gemoji [options]', "hoge")
    end
  end
end
